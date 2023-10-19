## Numero de noticias publicadas por Usuario

```
db.News.find({"user._id": ObjectId("ID_DEL_USUARIO")})
```

## 10 ultimas noticias publicadas

```
db.News.find().sort({ "date": -1 }).limit(10)
```

## Noticias que no tienen el campo tag

```
db.News.find({ "tags": { $exists: false } })
```

## Noticias publicadas en un periodo de fechas. Se podrian realizar consultas por anio, mes y dia sobre el campo de tipo ISOdate? Como?

```
db.News.find({ "date": { $gte: "2023-10-14", $lte: "2023-10-15" } })
```


En la coleccion noticias no tengo los campos "date" como tipo ISOdate, pero si se lo tuviera la consulta seria la siguiente:

```
db.News.find({ "date": { $gte: ISODate("2023-10-14T00:00:00Z"), $lte: ISODate("2023-10-15T23:59:59Z") } })
```

Para obtener los documentos deseados, tendriamos que jugar con las fechas.