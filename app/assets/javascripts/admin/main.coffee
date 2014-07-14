angular.module("nikolaWorkshopsAdmin", [
  "rails",
  "ngRoute",
  "templates",
  "ngQuickDate",
  "ui.bootstrap",
  "angularFileUpload"
])
.constant("workshopsUrl", "/admin/workshops")
.constant("hostImageUrl", "/images/create_host")
.constant("workshopImageUrl", "/images/create_workshop")
.factory("Workshop", ["railsResourceFactory", "workshopsUrl", "$templateCache", (railsResourceFactory, workshopsUrl, $templateCache) ->
  railsResourceFactory 
    url: "/workshops", 
    name: "workshop"
])
.config(['$routeProvider', '$locationProvider', 'workshopsUrl', ($routeProvider, $locationProvider, workshopsUrl) ->

  $locationProvider.html5Mode true

  $routeProvider.when "#{workshopsUrl}/:id/edit",
    templateUrl: "workshopsEditor.html"
    controller: "workshopsEditCtrl"
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]

  $routeProvider.when "#{workshopsUrl}/new",
    templateUrl: "workshopsEditor.html"
    controller: "workshopsEditCtrl"
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]

  $routeProvider.otherwise
    templateUrl: "workshopsTable.html"
    controller: "workshopsTableCtrl"
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]
])
.config(['ngQuickDateDefaultsProvider', (ngQuickDateDefaultsProvider) ->

  ngQuickDateDefaultsProvider.set 
    disableTimepicker: true,
    dateFormat: "dd.MM.yyyy",
    iconClass: "fa-calendar"
])