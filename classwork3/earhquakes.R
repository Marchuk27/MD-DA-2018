#Загружаю данные о землятресениях
anss <- readLines("https://raw.githubusercontent.com/SergeyMirvoda/MD-DA-2017/master/data/earthquakes_2011.html", warn=FALSE)
choosing_strings <- grep ("^\\d+/\\d+/\\d+\\s\\d+:\\d+:\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,\\w+,\\d+,,,-?\\d+\\.\\d+,\\w+,\\d+$", anss, value=TRUE)
choosing_strings

#Проверяю что все строки (all.equal) в результирующем векторе подходят под шаблон. 
all.equal(choosing_strings,"^\\d+/\\d+/\\d+\\s\\d+:\\d+:\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,-?\\d+\\.\\d+,\\w+,\\d+,,,-?\\d+\\.\\d+,\\w+,\\d+$")
