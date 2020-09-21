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
- Solo variantes tipo SNP con VAF (frecuecia alélica de la variante) mayor o igual a 0.05 (5%) y e InDels con VAF mayor o igual a 0.07(7%). Estos filtros basados en los limites de detección validados por el panel OCA (Oncomine Focus Assay | Thermo Fisher Scientific). Para mayor información del panel [link](https://docs.google.com/presentation/d/1RMWfWdQEMmEO8QXOeL9V23UQObzv1bLDHuzy44ZFx88/edit?usp=sharing)<br>

- Solo variantes con AF menor o igual 0.01 (1%) en las bases de datos de frecuencias alelicas poblacionales (GnomAD genoma, GnomAD exomas, ESP6500, ExaAC y 1000Genomas). De esta manera eliminamos polimorfismos de los datos.

## 2. Clasificación de variantes

- **2.1: Variantes encontradas en muestras de BC son clasificadas como variantes germinal**  
Aquellas variantes que fueron encontradas en las muestras de sangre (BC), secuenciadas por el panel de TumorSec, son etiquetadas como variantes germinales si han sido encontradas en las muestras tumorales.
Columnas en Excel<br>
clasificación: "Germinal"<br>
motivo:"variante_en_BC"<br>

- **2.2 Variantes con VAF mayor 0.60, son clasificadas como germinal.**<br>
Aquellas variantes con un número mayor a 0.6 en la columna ***VAF*** del archivo Excel, son etiquetadas como germinal.
Columnas en Excel<br>
clasificación: "Germinal"<br>
motivo: "VAF_sobre_0.6"<br>

- **2.3: Variantes no clasificadas y con Cosmic ID, son clasificadas como Somática.**<br>
Aquellas variantes con un ID en la columna ***cosmic92*** son aquellas variantes que ya han sido reportadas al menos una vez como variantes somáticas en la base de datos COSMIC [link](https://cancer.sanger.ac.uk/cosmic)
Columnas en Excel<br>
clasificación: "Somatica"<br>
motivo: "CosmicID"<br>

- **2.4: Variantes no clasificadas y con ID en snp138NonFlagged  es clasificada como germinal**<br>
Si la variante tiene rsID, en la columna ***snp138nonflagged***, significa que es una variante conocida con MAF mayor a 1%. (Base de datos dbSNP). Estas son clasificadas como germinal.
Ojo: flagged variants are those for which SNPs <1% MAF (or unknown), mapping only once to reference assembly, or flagged as “clinically associated”).
Columnas en Excel<br>
clasificación:"Germinal"<br>
motivo:"snp138NonFlagged"<br>

- **2.5: Variantes no clasificadas y con ID en avsnp150 y con AF en ExAC_nontcga_ALL es clasificada como variantes germina**l<br>
Aquellas variantes que no fueron clasificadas en los pasos anteriores, que presentan rsID en la columna ***avsnp150*** y AF reportada en la columna ***ExAC_nontcga_ALL*** , son clasificadas como varinates germinal. Esto quiere decir, que es una variante conocida que ha sido sido encontrada a bajas frecuencias alélicas en exomas de muestras de sangre (donde se excluyen las muestras con cancer (TCGA))
Columnas en Excel<br>
 clasificación: "Germinal"<br>
 motivo: "avsnp150_AND_ExAC_nontcga_ALL"<br>

- **2.6: Variantes no clasificadas y con rsID en avsnp150,son clasificadas como posible somatica**<br>
Aquellas variantes no clasificadas, que ademas tiene un rsID en la columna ***avsnp150*** es clasificada como posible somática. Esto debido a que es una variante que ya ha sido reportada, sin embargo, no hay indicios que sea germinal, ya que no se ha clasificado en los pasos anteriores.

Ojo: Existe la posibilidad que algunas de estas variantes, sean germinales. Debido a la baja representación de las poblaciones latinas en bases de  datos poblacionales. En caso de tener dudas, se puede realizar una revision manual del rsID en la página de dbSNP y/o en CLINVAR. 
Columnas en Excel<br>
clasificación: "Posible_Somatica"<br>
motivo: "avsnp150"<br>

- **2.7: Variantes no clasificadas y con AF muy bajas(menor a 0.01) en Bases de datos de frecuencias alélicas poblacionales, son clasificadas como posibles somáticas.**<br>
Ojo: Existe la posibilidad que algunas de estas variantes, sean germinales. Debido a la baja representación de las poblaciones latinas en bases de  datos poblacionales. En caso de tener dudas, se puede realizar una revision manual del rsID en la página de dbSNP y/o en CLINVAR.  
Columnas en Excel<br>
clasificación: "Posible_Somatica" <br>
motivo: "sin_rsID_con_AFpob_menor_0.01" <br>

- **2.8: Variantes que aun no son clasificadas, son etiquetadas como posibles variantes somáticas novel.**<br>
Aquellas variantes que no ha sido etiquetada en los pasos anteriores, es clasificada como posible variante somática novel. Debido a que no hay información de la variante en las bases de datos revisadas y tiene VAF mayor o igual a 0.6.

Columnas en Excel<br>
clasificación: "Posible_Somatica_Novel"<br>
motivo: "Sin_info_BDs"<br>
