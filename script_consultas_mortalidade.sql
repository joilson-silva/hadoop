--QUERY1- CINCO OCUPAÇÕES/PROFISSÕES QUE MAIS POSSUI OBITO POR ACIDENTE DE TRABALHO
Select ocupacao.dsc_ocupacao, count(*) as total_obito 
from mortalidade 
inner join ocupacao
  on mortalidade.ocup = ocupacao.cod_ocupacao
where mortalidade.acidtrab = 1 
group by ocupacao.dsc_ocupacao
order by 2 asc
limit 5;


--QUERY2- CINCO MUNICIPIO QUE MAIS POSSUI OBITO POR ACIDENTE DE TRABALHO

Select nome_municipio, count(*) as total_obito 
from mortalidade 
inner join municipio
  on codmunocor = substr(cod_municipio,1,6)
where mortalidade.acidtrab = 1 
group by nome_municipio
order by 2 desc
limit 5;



--QUERY3- 5 MUNICIPIOS COM O MAIOR NÚMERO DE ÓBITOS
Select nome_municipio, count(*) as total_obito
from mortalidade
inner join municipio
on codmunocor = substr(cod_municipio,1,6)
group by nome_municipio
order by 2 desc
limit 5;


--query4 - QUANTIDADE DE SUICIDIO POR CRIANÇAS


Select faixa_etaria, count(*)
from ( 
Select *, 
case when idade between 1 and 15 then 'Menor que 15 anos' 
when idade between 15 and 20 then 'Entre 15 e 20 anos' 
when idade between 21 and 40 then 'Entre 21 e 40 anos' 
when idade between 41 and 60 then 'Entre 41 e 60 anos' 
when idade > 60 then 'Maior que 60 anos' 
else 'Ignorada' end as faixa_etaria 
from (SELECT *, cast(substr(dtobito,7,10) as int) - cast(substr(dtnasc,7,10) as int) as idade from mortalidade where circobito in (2) and dtobito is not null and dtnasc is not null) as t1 
) as t2
group by faixa_etaria
order by 1 asc
limit 10;


--QUERY5 - 5 DOENÇAS QUE MAIS LEVAM A OBITO

Select descricao, count(*) as total_obito
from mortalidade
inner join cid10
on causabas = cod_subcat
group by descricao
order by 2 desc
limit 5;

--QUERY5 - 5 DOENÇAS QUE MAIS LEVAM A OBITO POR ANO
Select anoobito, descricao, count(*) as total_obito
from mortalidade
inner join cid10
on causabas = cod_subcat
group by anoobito, descricao
order by 3 desc;

