###Comandos utiles

Descargar base de datos con ANNOVAR
 sudo perl annotate_variation.pl -webfrom annovar -downdb abraom -buildver hg19 humandb/
 
Ejecutar ANNOVAR
 perl $SCRIPT_ANNOVAR $consensus_sINDEL_sSNV_PASS $ANNOVAR_HDB \
		-buildver hg19 \
		-out $output_annovar \
		-protocol refGene,gnomad211_genome,gnomad211_exome,esp6500siv2_all,exac03,exac03nontcga,snp138NonFlagged,AFR.sites.2015_08,AMR.sites.2015_08,EAS.sites.2015_08,EUR.sites.2015_08,SAS.sites.2015_08,dbnsfp35c,cadd13,avsnp150,cosmic92,clinvar_20200316 \
		-operation g,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f \
		-nastring . -vcfinput
 
