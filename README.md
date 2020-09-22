# Filtro y clasificación de variantes [Datos Damasco]

A partir de archivos VCFs del proyecto DAMASCO, se realizó la anotación de variantes con ANNOVAR y CGI, para todas las muestras por set(Colon_Cancer,Gallbladder_Cancer, Gastric_Cancer y Breast_Cancer).

Para la anotación con ANNOVAR se utilizaron las siguientes bases de datos.
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

Para más información y descripción de las bases de datos visitar el siguiente [link](https://annovar.openbioinformatics.org/en/latest/user-guide/filter/)<br>

Reference<br>
Wang K, Li M, Hakonarson H. ANNOVAR: Functional annotation of genetic variants from next-generation sequencing data Nucleic Acids Research, 38:e164, 2010

## 1. Filtro inical de variantes.

A partir de la unión de todas las variantes por set de datos en Damasco, se descartaron variantes basados en los siguientes criterios: <br>
- Solo variantes tipo SNV con VAF (frecuecia alélica de la variante) mayor o igual a 0.05 (5%) y e InDels con VAF mayor o igual a 0.07(7%). Estos filtros basados en los limites de detección validados por el panel OCA (Oncomine Focus Assay | Thermo Fisher Scientific). Para mayor información del panel [link](https://docs.google.com/presentation/d/1RMWfWdQEMmEO8QXOeL9V23UQObzv1bLDHuzy44ZFx88/edit?usp=sharing)<br>

- Solo variantes con AF menor o igual 0.01 (1%) reportadas en las bases de datos de frecuencias alelicas poblacionales (GnomAD-genoma, GnomAD-exomas, ESP6500, ExaAC y 1000Genomas). De esta manera eliminamos polimorfismos.

## 2. Clasificación de variantes

Aquellas variantes que pasaron los filtros mecionados en la sección anterior, fueron clasificadas como variantes: Germinal, Posible Germinal, Somática, Posible Somática y Posible Somática Novel. Esta información se encuentra en la columna ***clasificación*** del Excel generado por set de datos. <br>

La clasificación anterior se basa en los siguientes criterios:<br>

- **2.1: Variantes encontradas en muestras de BC, son clasificadas como variante germinal**  
Aquellas variantes que fueron encontradas en las muestras de sangre (BC), secuenciadas por el panel de TumorSec, son etiquetadas como variantes germinales si han sido encontradas en las muestras tumorales.<br>
Columnas en Excel<br>
clasificación: "Germinal"<br>
motivo:"variante_en_BC"<br>

- **2.2 Variantes con VAF mayor 0.45, son clasificadas como germinal.**<br>
Aquellas variantes con un número mayor a 0.45 en la columna ***VAF*** del archivo Excel, son etiquetadas como germinal.<br>
Columnas en Excel<br>
clasificación: "Germinal"<br>
motivo: "VAF_sobre_0.6"<br>

- **2.3: Variantes no clasificadas y con Cosmic ID, son clasificadas como Somática.**<br>
Aquellas variantes que hasta el momento no han sido clasificadas, y ademas tienen un ID en la columna ***cosmic92***, son clasificadas como somática. Estas ya han sido reportadas al menos una vez como variantes somáticas en la base de datos COSMIC [link](https://cancer.sanger.ac.uk/cosmic)<br>
Columnas en Excel<br>
clasificación: "Somatica"<br>
motivo: "CosmicID"<br>

- **2.4: Variantes no clasificadas y con ID en snp138NonFlagged son clasificadas como germinal**<br>
Si la variante tiene rsID, en la columna ***snp138nonflagged***, significa que es una variante conocida con MAF mayor a 1%. (Base de datos dbSNP). Aquellas variantes que no fueron clasificadas en los pasos anteriores y con rsID en ***snp138nonflagged*** son clasificadas como germinal.<b>
Ojo: flagged variants are those for which SNPs <1% MAF (or unknown), mapping only once to reference assembly, or flagged as “clinically associated”).<br>
Columnas en Excel<br>
clasificación:"Germinal"<br>
motivo:"snp138NonFlagged"<br>

- **2.5: Variantes no clasificadas y con ID en avsnp150 y con AF en ExAC_nontcga_ALL es clasificada como variantes germina**<br>
Aquellas variantes que no fueron clasificadas en los pasos anteriores, que presentan rsID en la columna ***avsnp150*** y AF reportada en la columna ***ExAC_nontcga_ALL*** , son clasificadas como posible germinal. Esto quiere decir, que es una variante conocida que ha sido sido encontrada a bajas frecuencias alélicas en exomas de muestras de sangre (donde se excluyen las muestras con cancer (TCGA))<br>
Columnas en Excel<br>
clasificación: "Posible_Germinal"<br>
motivo: "avsnp150_AND_ExAC_nontcga_ALL"<br>

- **2.6: Variantes no clasificadas y con rsID en avsnp150,son clasificadas como posible somatica** <br>
Aquellas variantes no clasificadas, que ademas tiene un rsID en la columna ***avsnp150*** es clasificada como posible somática. Esto debido a que es una variante que ya ha sido reportada, sin embargo, no hay indicios que sea germinal (ya que no se ha clasificado en los pasos anteriores).<br>
Ojo: Existe la posibilidad que algunas de estas variantes, sean germinales. Debido a la baja representación de las poblaciones latinas en bases de  datos poblacionales. En caso de tener dudas, se puede realizar una revision manual del rsID en la página de dbSNP y/o en CLINVAR. <br>
Columnas en Excel<br>
clasificación: "Posible_Somatica"<br>
motivo: "avsnp150"<br>

- **2.7: Variantes no clasificadas y con AF muy bajas (menor a 0.01) en bases de datos de frecuencias alélicas poblacionales, son clasificadas como posibles somáticas.**<br>
Aquellas variantes que hasta el momento no han sido clasificadas y presentan AF poblacional en GnomAD, ExAC, ESP o/y 1000Genomas (entre 0-0.01), son clasificadas como posibles somáticas. 
Ojo: Existe la posibilidad que algunas de estas variantes, sean germinales. Debido a la baja representación de las poblaciones latinas en bases de  datos poblacionales. En caso de tener dudas, se puede realizar una revision manual del rsID en la página de dbSNP y/o en CLINVAR.<br>
Columnas en Excel<br>
clasificación: "Posible_Somatica" <br>
motivo: "sin_rsID_con_AFpob_menor_0.01" <br>

- **2.8: Variantes que aun no son clasificadas, son etiquetadas como posibles variantes somáticas novel.**<br>
Aquellas variantes que no han sido etiquetada en los pasos anteriores, son clasificada como "posible somática novel". Esto, debido a que no hay información de la variante en las bases de datos revisadas y tiene VAF menor o igual a 0.45 <br>
Columnas en Excel<br>
clasificación: "Posible_Somatica_Novel"<br>
motivo: "Sin_info_BDs"<br>





