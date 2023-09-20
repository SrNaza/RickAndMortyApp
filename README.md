# RickAndMortyApp
Zara Tech Tests / Nazareth Villalba

Patron arquitectonico utilizado : VIPER

El ejercicio consta principalmente de 3 pantallas:

 1 - Vista principal con campo de busqueda HomeViewController.swift

 2 - Listado de los Personajes con un collectionView ListViewController.swift

 3 - Detalle de un Personaje seleccionado DetailViewController.swift
   * DetailViewController es una vista hecha con NS
 
Cada una presentada con el flujo necesario que amerita el manejo del patron Viper mas una capa de Servicio en con junto con 
el interactor y NetworkingServices.swift para la consulta a la api publica de mercado libre.

Tecnologias: 

programacion reactiva con rxSwift

consultas HTTP - alamofire

pruebas unitarias

* Alamofire / AlamofireObjectMapper
* RxSwift / RxCocoa
* SDWebImage
