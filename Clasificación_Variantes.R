library(maftools)
library(tidyr)

##Programa que a partir de las anotaciones en ANNOVAR, resultados del pipeline de TumorSec. 
## Se realizan los filtros para eliminar variantes germinales de las muestras de Tumor. 
## Las variantes restantes se clasifican como:
 # Variantes somáticas

## Variantes germinales. 
## Crear dataframe con las anotación (ANNOVAR) de todas las muestras.
path_input="/Users/evelin/Documents/07-09-20-DAMASCO_ANNOVAR_CGI/"
list_germ="/Users/evelin/Documents/07-09-20-DAMASCO_ANNOVAR_CGI/all_samplesCamama_annovar/"
filenames_germ <- Sys.glob(paste0(list_germ,"*.hg19_multianno.txt"))
annovar_germ = lapply(filenames_germ, annovarToMaf) #convert to MAFs using annovarToMaf
annovar_germ.all = data.table::rbindlist(l = annovar_germ, fill = TRUE) #Merge into single MAF
annovar_germ.all$ID_variante<-paste(annovar_germ.all$Start_Position,annovar_germ.all$Reference_Allele,annovar_germ.all$Tumor_Seq_Allele2,sep='|')
VAR_GERM<-unique(annovar_germ.all$ID_variante)
 
## Crear dataframe con las anotación (ANNOVAR) de todas las muestras.
list_anno="/Users/evelin/Documents/07-09-20-DAMASCO_ANNOVAR_CGI/4_join_ANNOVAR_CGI/Colon_Cancer/All_ANNOVAR/"
filenames <- Sys.glob(paste0(list_anno,"*.hg19_multianno.txt"))
annovar_mafs = lapply(filenames, annovarToMaf) #convert to MAFs using annovarToMaf
annovar_mafs = data.table::rbindlist(l = annovar_mafs, fill = TRUE) #Merge into single MAF
annovar_mafs$Variant_Type[annovar_mafs$Variant_Type=="MNP"]<-"SNP"

colnames(annovar_mafs) <- make.unique(names(annovar_mafs))

annovar_mafs.sep<-annovar_mafs %>% separate(V144, c("GT","GQ","DP","FDP","RO","FRO","AO","FAO","VAF","SAR"), "[:]")

# FILTRO 1: Variantes con SNP con AF mayor o igual a 0.05 (5%) e InDels con AF mayor o igual 0.07(7%).
annovar_mafs.sep.af<-annovar_mafs.sep[(annovar_mafs.sep$Variant_Type=="DEL" & annovar_mafs.sep$VAF>=0.07) | (annovar_mafs.sep$Variant_Type=="INS" & annovar_mafs.sep$VAF>=0.07) | annovar_mafs.sep$Variant_Type=="SNP",]

#FILTRO 2: Variantes con AF en ExAC, ESP, 1000Genomas , GnomAD exoma y GnomAD genoma, menor o igual a 0.01(1%).
annovar_mafs.sep.af<-annovar_mafs.sep.af %>%
  naniar::replace_with_na_if(.predicate = is.character,
                             condition = ~.x %in% ("."))
AFpob<-annovar_mafs.sep.af
##GNOMAD GENOMA
AFpob<-AFpob[as.numeric(AFpob$AF.1)<=0.01 | is.na(AFpob$AF.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_popmax.1)<=0.01 | is.na(AFpob$AF_popmax.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_male.1)<=0.01 | is.na(AFpob$AF_male.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_female.1)<=0.01 | is.na(AFpob$AF_female.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_raw.1)<=0.01 | is.na(AFpob$AF_raw.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_afr.1)<=0.01 | is.na(AFpob$AF_afr.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_sas.1)<=0.01 | is.na(AFpob$AF_sas.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_amr.1)<=0.01 | is.na(AFpob$AF_amr.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_eas.1)<=0.01 | is.na(AFpob$AF_eas.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_nfe.1)<=0.01 | is.na(AFpob$AF_nfe.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_fin.1)<=0.01 | is.na(AFpob$AF_fin.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_asj.1)<=0.01 | is.na(AFpob$AF_asj.1),]
AFpob<-AFpob[as.numeric(AFpob$AF_oth.1)<=0.01 | is.na(AFpob$AF_oth.1),]
AFpob<-AFpob[as.numeric(AFpob$non_topmed_AF_popmax.1)<=0.01 | is.na(AFpob$non_topmed_AF_popmax.1),]
AFpob<-AFpob[as.numeric(AFpob$non_neuro_AF_popmax.1)<=0.01 | is.na(AFpob$non_neuro_AF_popmax.1),]
AFpob<-AFpob[as.numeric(AFpob$non_cancer_AF_popmax.1)<=0.01 | is.na(AFpob$non_cancer_AF_popmax.1),]
#GNOMAD EXOMA
AFpob<-AFpob[as.numeric(AFpob$AF)<=0.01 | is.na(AFpob$AF),]
AFpob<-AFpob[as.numeric(AFpob$AF_popmax)<=0.01 | is.na(AFpob$AF_popmax),]
AFpob<-AFpob[as.numeric(AFpob$AF_male)<=0.01 | is.na(AFpob$AF_male),]
AFpob<-AFpob[as.numeric(AFpob$AF_female)<=0.01 | is.na(AFpob$AF_female),]
AFpob<-AFpob[as.numeric(AFpob$AF_raw)<=0.01 | is.na(AFpob$AF_raw),]
AFpob<-AFpob[as.numeric(AFpob$AF_afr)<=0.01 | is.na(AFpob$AF_afr),]
AFpob<-AFpob[as.numeric(AFpob$AF_sas)<=0.01 | is.na(AFpob$AF_sas),]
AFpob<-AFpob[as.numeric(AFpob$AF_amr)<=0.01 | is.na(AFpob$AF_amr),]
AFpob<-AFpob[as.numeric(AFpob$AF_eas)<=0.01 | is.na(AFpob$AF_eas),]
AFpob<-AFpob[as.numeric(AFpob$AF_nfe)<=0.01 | is.na(AFpob$AF_nfe),]
AFpob<-AFpob[as.numeric(AFpob$AF_fin)<=0.01 | is.na(AFpob$AF_fin),]
AFpob<-AFpob[as.numeric(AFpob$AF_asj)<=0.01 | is.na(AFpob$AF_asj),]
AFpob<-AFpob[as.numeric(AFpob$AF_oth)<=0.01 | is.na(AFpob$AF_oth),]
AFpob<-AFpob[as.numeric(AFpob$non_topmed_AF_popmax)<=0.01 | is.na(AFpob$non_topmed_AF_popmax),]
AFpob<-AFpob[as.numeric(AFpob$non_neuro_AF_popmax)<=0.01 | is.na(AFpob$non_neuro_AF_popmax),]
AFpob<-AFpob[as.numeric(AFpob$non_cancer_AF_popmax)<=0.01 | is.na(AFpob$non_cancer_AF_popmax),]
## 1000GENOMAS
AFpob<-AFpob[as.numeric(AFpob$esp6500siv2_all)<=0.01 | is.na(AFpob$esp6500siv2_all),]
AFpob<-AFpob[as.numeric(AFpob$AFR.sites.2015_08)<=0.01 | is.na(AFpob$AFR.sites.2015_08),]
AFpob<-AFpob[as.numeric(AFpob$AMR.sites.2015_08)<=0.01 | is.na(AFpob$AMR.sites.2015_08),]
AFpob<-AFpob[as.numeric(AFpob$EAS.sites.2015_08)<=0.01 | is.na(AFpob$EAS.sites.2015_08),]
AFpob<-AFpob[as.numeric(AFpob$EUR.sites.2015_08)<=0.01 | is.na(AFpob$EUR.sites.2015_08),]
AFpob<-AFpob[as.numeric(AFpob$SAS.sites.2015_08)<=0.01 | is.na(AFpob$SAS.sites.2015_08),]
## EXAC
AFpob<-AFpob[as.numeric(AFpob$ExAC_ALL)<=0.01 | is.na(AFpob$ExAC_ALL),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_AFR)<=0.01 | is.na(AFpob$ExAC_AFR),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_AMR)<=0.01 | is.na(AFpob$ExAC_AMR),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_EAS)<=0.01 | is.na(AFpob$ExAC_EAS),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_FIN)<=0.01 | is.na(AFpob$ExAC_FIN),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_NFE)<=0.01 | is.na(AFpob$ExAC_NFE),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_OTH)<=0.01 | is.na(AFpob$ExAC_OTH),]
AFpob<-AFpob[as.numeric(AFpob$ExAC_SAS)<=0.01 | is.na(AFpob$ExAC_SAS),]

##ESP
AFpob<-AFpob[as.numeric(AFpob$esp6500siv2_all)<=0.01 | is.na(AFpob$esp6500siv2_all),]

#creamos ID de variante, con Posición|referencia|alteracion
AFpob$ID_variante<-paste(AFpob$Start_Position,AFpob$Reference_Allele,AFpob$Tumor_Seq_Allele2,sep='|')

#FILTRO 3: CLASIFICACIÓN DE VARIANTES.

##FILTRO 3.1: Variantes encontradas en muestras de BC son clasificadas como variantes germinal  
AFpob$clasificacion[AFpob$ID_variante %in% VAR_GERM]<-"Germinal"
AFpob$motivo[AFpob$ID_variante %in% VAR_GERM]<-"variante_en_BC"

## Filtro 3.2 variantes con VAF entre 0.60-1, son clasificadas como germinal. 
AFpob$clasificacion[as.numeric(AFpob$VAF)>=0.6]<-"Germinal"
AFpob$motivo[as.numeric(AFpob$VAF)>=0.6]<-"VAF_sobre_0.6"

## FILTRO 3.3: Variantes no clasificadas y con Cosmic ID son clasificadas como somáticas
AFpob$clasificacion[is.na(AFpob$clasificacion) & !is.na(AFpob$cosmic92)]<-"Somatica"
AFpob$motivo[ AFpob$clasificacion=="Somatica" & !is.na(AFpob$cosmic92)]<-"CosmicID"

## FILTRO 3.4: Variantes no clasificadas y con ID en snp138NonFlagged  es clasificada como germinal
## snp138nonflagged: Si la variante tiene RSID, en la columna 
## snp138nonflagged ((flagged variants are those for which SNPs <1% MAF (or unknown), mapping only once to reference assembly, or flagged as “clinically associated”).)
AFpob$clasificacion[ is.na(AFpob$clasificacion) & !is.na(AFpob$snp138NonFlagged)]<-"Germinal"
AFpob$motivo[ AFpob$clasificacion=="Germinal" & !is.na(AFpob$snp138NonFlagged)]<-"snp138NonFlagged"

## FILTRO 3.5: Variantes no clasificadas y con ID en avsnp150 y con AF en ExAC_nontcga_ALL es clasificada como variantes germinal
AFpob$clasificacion[ is.na(AFpob$clasificacion) & !is.na(AFpob$avsnp150) & !is.na(AFpob$ExAC_nontcga_ALL)]<-"Germinal"
AFpob$motivo[ AFpob$clasificacion=="Germinal" & !is.na(AFpob$avsnp150) & !is.na(AFpob$ExAC_nontcga_ALL)]<-"avsnp150_AND_ExAC_nontcga_ALL"

## FILTRO 3.6: Variantes no clasificadas y con ID en avsnp150, es clasificada como posible somatica
AFpob$clasificacion[is.na(AFpob$clasificacion) & !is.na(AFpob$avsnp150)]<-"Posible_Somatica"
AFpob$motivo[ AFpob$clasificacion=="Posible_Somatica" & !is.na(AFpob$avsnp150)]<-"avsnp150"

## FILTRO 3.7 Variantes con AF muy bajas en Bases de datos de frecuencias alélicas poblacionales, menor < 0.01, son clasificadas como posibles somáticas. 
AFpob$clasificacion[is.na(AFpob$clasificacion) & (!is.na(AFpob$ExAC_ALL) | !is.na(AFpob$AF_popmax) | !is.na(AFpob$AF_popmax.1) | !is.na(AFpob$AMR.sites.2015_08))]<-"Posible_Somatica"
AFpob$motivo[ AFpob$clasificacion=="Posible_Somatica" & (!is.na(AFpob$ExAC_ALL) | !is.na(AFpob$AF_popmax) | !is.na(AFpob$AF_popmax.1) | !is.na(AFpob$AMR.sites.2015_08))]<-"sin_rsID_con_AFpob_menor_0.01"

## FILTRO 3.7: Aquellas variantes sin informacion en Bases de datos, son clasificadas como posibles variantes somáticas novel.
AFpob$clasificacion[is.na(AFpob$clasificacion)]<-"Posible_Somatica_Novel"
AFpob$motivo[AFpob$clasificacion=="Posible_Somatica_Novel"]<-"Sin_info_BDs"

write.table(AFpob,file = paste0(path_input,"/Colon_Cancer_OCA_ClasificacionVarinates.tsv"), sep ='\t', quote=FALSE, row.names = F)


