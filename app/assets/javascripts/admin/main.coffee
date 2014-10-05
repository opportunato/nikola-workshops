angular.module("nikolaWorkshopsAdmin", [
  "rails",
  "ngRoute",
  "templates",
  "ui.bootstrap",
  "textAngular",
  "angularFileUpload"
])
.constant("workshopsUrl", "/admin/workshops")
.constant("tagsUrl", "/admin/tags")
.constant("feedUrl", "/admin/feed")
.constant("workshopsUserUrl", "/workshops")
.constant("hostImageUrl", "/images/create_host")
.constant("workshopImageUrl", "/images/create_workshop")
.factory("Workshop", ["railsResourceFactory", "workshopsUrl", "$templateCache", (railsResourceFactory, workshopsUrl, $templateCache) ->
  railsResourceFactory 
    url: "/workshops", 
    name: "workshop"
])
.factory("Tag", ["railsResourceFactory", "tagsUrl", "$templateCache", (railsResourceFactory, tagsUrl, $templateCache) ->
  railsResourceFactory 
    url: "/tags", 
    name: "tag"
])
.factory("FeedImage", ["railsResourceFactory", "feedUrl", "$templateCache", (railsResourceFactory, feedUrl, $templateCache) ->
  railsResourceFactory 
    url: "/feed_images", 
    name: "feed_image"
])
.config(['$routeProvider', '$locationProvider', 'workshopsUrl', 'tagsUrl', 'feedUrl', ($routeProvider, $locationProvider, workshopsUrl, tagsUrl, feedUrl) ->

  $locationProvider.html5Mode true

  $routeProvider.when "#{workshopsUrl}/:id/edit",
    templateUrl: "workshopsEditor.html"
    controller: "workshopsEditCtrl"
    reloadOnSearch: false
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]

  $routeProvider.when "#{workshopsUrl}/new",
    templateUrl: "workshopsEditor.html"
    controller: "workshopsEditCtrl"
    reloadOnSearch: false
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]

  $routeProvider.when "#{tagsUrl}/new",
    templateUrl: "tagsEditor.html"
    controller: "tagsEditCtrl"
    reloadOnSearch: false
    resolve:
      tags: ['Tag', (Tag) ->
        Tag.query()
      ]

  $routeProvider.when "#{tagsUrl}",
    templateUrl: "tagsTable.html"
    controller: "tagsTableCtrl"
    reloadOnSearch: false
    resolve:
      tags: ['Tag', (Tag) ->
        Tag.query()
      ]

  $routeProvider.when "#{feedUrl}",
    templateUrl: "feedTable.html"
    controller: "feedTableCtrl"
    reloadOnSearch: false
    resolve:
      feedImages: ['FeedImage', (FeedImage) ->
        FeedImage.query()
      ]

  $routeProvider.otherwise
    templateUrl: "workshopsTable.html"
    controller: "workshopsTableCtrl"
    resolve:
      workshops: ['Workshop', (Workshop) ->
        Workshop.query()
      ]
])