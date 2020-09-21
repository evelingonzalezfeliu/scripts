# Filtro y clasificación de variantes [Datos Damasco]

A partir de archivos VCFs, se realizó de variantes con ANNOVAR y CGI(Cancer )


## Filtro de variantes.

## 2. Clasificación de variantes

### Filtro 2.2 variantes con VAF entre 0.60-1, son clasificadas como germinal. 
clasificacion<-"Germinal"
motivo<-"VAF_sobre_0.6"

### FILTRO 2.3: Variantes no clasificadas y con Cosmic ID son clasificadas como somáticas
clasificacion<-"Somatica"
motivo<-"CosmicID"

### FILTRO 2.4: Variantes no clasificadas y con ID en snp138NonFlagged  es clasificada como germinal
snp138nonflagged: Si la variante tiene RSID, en la columna 
snp138nonflagged ((flagged variants are those for which SNPs <1% MAF (or unknown), mapping only once to reference assembly, or flagged as “clinically associated”).)
clasificacion<-"Germinal"
motivo<-"snp138NonFlagged"

### FILTRO 2.5: Variantes no clasificadas y con ID en avsnp150 y con AF en ExAC_nontcga_ALL es clasificada como variantes germinal
clasificacion<-"Germinal"
motivo<-"avsnp150_AND_ExAC_nontcga_ALL"

### FILTRO 2.6: Variantes no clasificadas y con ID en avsnp150, es clasificada como posible somatica
clasificacion<-"Posible_Somatica"
motivo<-"avsnp150"

### FILTRO 2.7 Variantes con AF muy bajas en Bases de datos de frecuencias alélicas poblacionales, menor < 0.01, son clasificadas como posibles somáticas. 
clasificacion<-"Posible_Somatica"
motivo<-"sin_rsID_con_AFpob_menor_0.01"

### FILTRO 2.8: Aquellas variantes sin informacion en Bases de datos, son clasificadas como posibles variantes somáticas novel.
clasificacion<-"Posible_Somatica_Novel"
motivo<-"Sin_info_BDs"
