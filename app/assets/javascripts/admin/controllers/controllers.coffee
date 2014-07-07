angular.module("nikolaWorkshopsAdmin")
.controller("adminCtrl", ['$scope', '$location', 'Workshop', 'workshopsUrl', ($scope, $location, Workshop, workshopsUrl) ->
  $scope.workshopsUrl = workshopsUrl
  $scope.data = {}

  $scope.createWorkshop = (workshop) ->
    new Workshop(workshop).create().then (newWorkshop) ->
      $scope.data.workshops.push newWorkshop
      $location.path $scope.workshopsUrl

  $scope.deleteWorkshop = (workshop) ->
    workshop.delete().then ->
      $scope.data.workshops.splice $scope.data.workshops.indexOf(workshop), 1

    $location.path $scope.workshopsUrl
])

.controller("workshopsTableCtrl", ['$scope', '$location', '$route', 'workshops', ($scope, $location, $route, workshops) ->
  $scope.data.workshops = workshops

  $scope.startEdit = (workshop) ->
    $location.path "#{$scope.workshopsUrl}/#{workshop.id}/edit"
])

.controller("workshopsEditCtrl", ['$scope', '$routeParams', '$location', 'workshops', 'Workshop', ($scope, $routeParams, $location, workshops, Workshop) ->
  $scope.data.workshops = workshops

  $scope.$watch 'data.workshops.length', ->
    if id = $routeParams["id"]
      $scope.currentWorkshop = ($scope.data.workshops.filter (workshop) ->
        if workshop.id == parseInt(id)
          $scope.currentWorkshop = workshop
      )[0]
    else
      $scope.currentWorkshop = new Workshop

  $scope.cancelEdit = ->
    $location.path $scope.workshopsUrl

  $scope.updateWorkshop = (workshop) ->
    workshop.update()
    $location.path $scope.workshopsUrl

  $scope.saveWorkshop = ->
    if angular.isDefined($scope.currentWorkshop.id)
      $scope.updateWorkshop $scope.currentWorkshop
    else
      $scope.createWorkshop $scope.currentWorkshop
    $scope.currentWorkshop = new Workshop
])

.controller("hostsCtrl", ['$scope', '$upload', 'hostImageUrl', ($scope, $upload, hostImageUrl) ->
  $scope.newHost = {}

  $scope.deleteHost = (host) ->
    hosts = $scope.currentWorkshop.hosts
    hosts.splice hosts.indexOf(host), 1

  $scope.addHost = ->
    $scope.currentWorkshop.hosts ||= []
    $scope.currentWorkshop.hosts.push($scope.newHost)

    $scope.newHost = {}

  $scope.uploadImage = ($files, host) ->

    for $file in $files
      $scope.upload = $upload.upload(
        url: hostImageUrl
        file: $file
        fileFormDataName: 'image'
      ).success((data, status, headers, config) ->
        host.image = data.url
        host.imageId = data.id
      )
])

.controller("videosCtrl", ['$scope', ($scope) ->
  $scope.newVideo = {}

  $scope.deleteVideo = (host) ->
    videos = $scope.currentWorkshop.videos
    videos.splice videos.indexOf(video), 1

  $scope.addVideo = ->
    $scope.currentWorkshop.videos ||= []
    $scope.currentWorkshop.videos.push($scope.newVideo)
    $scope.newVideo = {}
])

.controller("imagesCtrl", ['$scope', 'workshopImageUrl', '$upload', ($scope, workshopImageUrl, $upload) ->

  $scope.deleteImage = (image) ->
    images = $scope.currentWorkshop.images
    images.splice images.indexOf(image), 1

  $scope.uploadImages = ($files, host) ->
    $scope.currentWorkshop.images ||= []

    for $file in $files
      $scope.upload = $upload.upload(
        url: workshopImageUrl
        file: $file
        fileFormDataName: 'image'
      ).success((data, status, headers, config) ->
        $scope.currentWorkshop.images.push data
      )
])

