# Filtro y clasificación de variantes [Datos Damasco]

A partir de archivos VCFs, se realizó de variantes con ANNOVAR y CGI. 

Para la anotación con ANNOVAR se utilizaron las sguientes bases de datos.
- refGene
- gnomad211_genome 
- gnomad211_exome
- esp6500siv2_all
- exac03nontcga
- snp138NonFlagged
- 1000Genomas (2015)
- dbnsfp35c
- cadd13
- avsnp150
- cosmic92
- clinvar_20200316

Para mas información y descripción de las bases de datos visitar el siguiente [link](https://annovar.openbioinformatics.org/en/latest/user-guide/filter/)

Reference
Wang K, Li M, Hakonarson H. ANNOVAR: Functional annotation of genetic variants from next-generation sequencing data Nucleic Acids Research, 38:e164, 2010

## 1. Filtro inical de variantes.

A partir de la uníon de todas las variantes por set de datos en Damasco, se eliminaron variantes basados en los siguientes criterios: <br>
- Solo variantes tipo SNP con VAF (frecuecia alélica de la variante) mayor o igual a 0.05 (5%) y e InDels con VAF mayor o igual a 0.07(7%). Estos filtros basados en los limites de detección validados por el panel OCA (Oncomine Focus Assay | Thermo Fisher Scientific). Para mayor información del panel [link](https://docs.google.com/presentation/d/1RMWfWdQEMmEO8QXOeL9V23UQObzv1bLDHuzy44ZFx88/edit?usp=sharing)

## 2. Clasificación de variantes

- **2.2 Variantes con VAF mayor 0.60, son clasificadas como germinal.**<br>
Columnas en Excel<br>
clasificacion: "Germinal"<br>
motivo: "VAF_sobre_0.6"<br>

- **2.3: Variantes no clasificadas y con Cosmic ID. Somática.**<br>
Columnas en Excel<br>
clasificación: "Somatica"<br>
motivo: "CosmicID"<br>

- **2.4: Variantes no clasificadas y con ID en snp138NonFlagged  es clasificada como germinal**<br>
snp138nonflagged: Si la variante tiene RSID, en la columna 
snp138nonflagged ((flagged variants are those for which SNPs <1% MAF (or unknown), mapping only once to reference assembly, or flagged as “clinically associated”).)
Columnas en Excel<br>
clasificación:"Germinal"<br>
motivo:"snp138NonFlagged"<br>

- **2.5: Variantes no clasificadas y con ID en avsnp150 y con AF en ExAC_nontcga_ALL es clasificada como variantes germina**l<br>
Columnas en Excel<br>
clasificacion: "Germinal"<br>
motivo: "avsnp150_AND_ExAC_nontcga_ALL"<br>

- **2.6: Variantes no clasificadas y con ID en avsnp150, es clasificada como posible somatica**<br>
Columnas en Excel<br>
clasificacion: "Posible_Somatica"<br>
motivo: "avsnp150"<br>

- **2.7: Variantes con AF muy bajas en Bases de datos de frecuencias alélicas poblacionales, menor < 0.01, son clasificadas como posibles somáticas.**<br>
Columnas en Excel<br>
clasificacion: "Posible_Somatica" <br>
motivo: "sin_rsID_con_AFpob_menor_0.01" <br>

- **2.8: Aquellas variantes sin informacion en Bases de datos, son clasificadas como posibles variantes somáticas novel.**<br>
Columnas en Excel<br>
clasificación: "Posible_Somatica_Novel"<br>
motivo: "Sin_info_BDs"<br>