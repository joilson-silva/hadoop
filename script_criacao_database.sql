create database if not exists projetohadoop
comment "Banco de dados referente ao projeto de pós graduação Infnet sobre a disciplina de Hadoop"
location "/user/joilson_rj/projeto_hadoop"
with DBPROPERTIES('Date'='2024-09-04', 'Country'='BR', 'Creator'='Joilson Silva');

-------------------Mortalidade-----------------------

CREATE EXTERNAL TABLE mortalidade(
ANOOBITO String,
TIPOBITO int,
DTOBITO String,
CODMUNNATU int,
DTNASC String,
SEXO String,
RACACOR int,
ESTCIV int,
OCUP int,
CODMUNRES int,
LOCOCOR int,
CODESTAB int,
CODMUNOCOR int,
IDADEMAE int,
OCUPMAE int,
OBITOPARTO int,
OBITOGRAV int,
ASSISTMED int,
NECROPSIA int,
CAUSABAS String,
CIRCOBITO int,
ACIDTRAB int,
TPPOS int,
DTINVESTIG String,
CAUSABAS_O String,
DTCADASTRO String,
ATESTANTE int,
ESCMAEAGR1 String,
ESCFALAGR1 String,
NUDIASOBCO int,
TPOBITOCOR int,
TPRESGINFO int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/mortalidade_csv';

------------------Municipio-----------------------------

CREATE EXTERNAL TABLE municipio(
cod_uf int, 
cod_municipio int, 
nome_municipio string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/municipio';


--------------------Estado------------------------------

CREATE EXTERNAL TABLE estado(
cod_uf int,
sigla string,
nome_estado string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/estado';


--------------------Ocupacao----------------------------

CREATE EXTERNAL TABLE ocupacao(
cod_ocupacao int,
dsc_ocupacao string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/ocupacao';


--------------------Leito----------------------------

CREATE EXTERNAL TABLE leito_partition(
regiao string,
uf string,
municipio string,
cnes string,
nome_estabelecimento string,
co_tipo_unidade string,
ds_tipo_unidade string,
desc_natureza_juridica string, 
no_bairro string,
leitos_existentes int,
leitos_sus int,
uti_total_exist int,
uti_total_sus int,
uti_adulto_exist int,
uti_adulto_sus int,
uti_pediatrico_exist int,
uti_pediatrico_sus int,
uti_neonatal_exist int,
uti_neonatal_sus int,
uti_queimado_exist int,
uti_queimado_sus int,
uti_coronariana_exist int,
uti_coronariana_sus int
)
PARTITIONED BY(COMP String)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/projeto_hadoop';


INSERT OVERWRITE TABLE leito_partition
PARTITION(COMP)
SELECT *
FROM leito;


INSERT OVERWRITE TABLE mortalidade
PARTITION(ANOOBITO)
SELECT * 
FROM mortalidades;

ALTER TABLE leito_partition RENAME TO leito
--------------------cid10----------------------------

CREATE EXTERNAL TABLE cid10(
cod_subcat String,
descricao String,
descrabrev String
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/joilson_rj/cid10';