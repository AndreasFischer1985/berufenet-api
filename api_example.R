##################
# Simple Examples
##################

install.packages(c("devtools","jsonlite","httr","stringr"))
devtools::install_github("AndreasFischer1985/qqBaseX")

# Get API-Key
#-------------
x=httr::GET("https://web.arbeitsagentur.de/berufenet/ergebnisseite/berufe-a-z?buchstabe=a&page=0")
xApiKey=stringr::str_match_all(httr::content(x,"text"),"client.*'")[[1]][,1]
xApiKey=substr(xApiKey,12,nchar(xApiKey)-1)

# Alle Berufe
#-------------
url="https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe?suchwoerter=*"
x=rawToChar(httr::content(httr::GET(url, httr::add_headers("X-API-Key"="d672172b-f3ef-4746-b659-227c39d95acf"))))
pages=jsonlite::fromJSON(x)$page$totalPages
x=lapply(0:(pages-1),function(x) rawToChar(httr::content(httr::GET(paste0(url,"&page=",x), 
	httr::add_headers("X-API-Key"="d672172b-f3ef-4746-b659-227c39d95acf")))))

y=data.frame(
unlist(lapply(x,function(x)jsonlite::fromJSON(x)$'_embedded'$berufSucheList[,1])),
unlist(sapply(x,function(x)jsonlite::fromJSON(x)$'_embedded'$berufSucheList[,2])))
colnames(y)=c("id","kurzBezeichnungNeutral")
write.csv2(y,"berufe.csv")

# Ind. Berufsdaten
#-----------------------
url="https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe/27272"
x=httr::content(httr::GET(url, httr::add_headers("X-API-Key"="d672172b-f3ef-4746-b659-227c39d95acf")))

x=lapply(y$id, function(id){
	print(id);
	httr::content(
	httr::GET(paste0("https://rest.arbeitsagentur.de/infosysbub/bnet/pc/v1/berufe/",id), 
	httr::add_headers("X-API-Key"="d672172b-f3ef-4746-b659-227c39d95acf")))})

saveRDS(x,"berufenet-infos.rds")
j=jsonlite::toJSON(x) #pretty=TRUE,auto_unbox=TRUE)

writeLines(j, "berufenet-infos.json", useBytes=T)
writeLines(jsonlite::toJSON(x[[1]]), "berufenet-infos_bsp1.json", useBytes=T)

