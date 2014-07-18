angular.module("nikolaWorkshopsAdmin")
.controller("adminCtrl", ['$scope', '$location', 'Workshop', 'workshopsUrl', 'workshopsUserUrl', ($scope, $location, Workshop, workshopsUrl, workshopsUserUrl) ->
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

  $scope.getWorkshopUserLink = (id) ->
    "#{workshopsUserUrl}/#{id}"
])

.controller("workshopsTableCtrl", ['$scope', '$location', '$route', 'workshops', ($scope, $location, $route, workshops) ->
  $scope.data.workshops = workshops

  $location.search 'tab', null

  $scope.startEdit = (workshop) ->
    $location.path "#{$scope.workshopsUrl}/#{workshop.id}/edit"
])

.controller("workshopsEditCtrl", ['$scope', '$routeParams', '$location', 'workshops', 'Workshop', 'workshopsUserUrl', '$rootScope', ($scope, $routeParams, $location, workshops, Workshop, workshopsUserUrl, $rootScope) ->
  $scope.newHost = {}
  $scope.newVideo = {}

  $scope.editorTabs =
    main: false
    hosts: false
    videos: false
    images: false

  currentTab = $location.search()['tab'] || "main"

  $scope.editorTabs[currentTab] = true

  $scope.selectTab = (tabName) ->
    $location.search 'tab', tabName

  $scope.data.workshops = workshops

  $scope.controls = {}

  $scope.controls.startDatePopupOpened = false
  $scope.controls.endDatePopupOpened = false

  $scope.open = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.controls.startDatePopupOpened = true
    $scope.controls.endDatePopupOpened = false

  $scope.openEndDate = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.controls.startDatePopupOpened = false
    $scope.controls.endDatePopupOpened = true

  $scope.$watch 'data.workshops.length', ->
    if id = $routeParams['id']
      $scope.currentWorkshop = ($scope.data.workshops.filter (workshop) ->
        if workshop.id == parseInt(id)
          $scope.currentWorkshop = workshop

          $scope.currentWorkshop.startDate = new Date($scope.currentWorkshop.startDate)
          $scope.currentWorkshop.endDate = new Date($scope.currentWorkshop.endDate)
      )[0]
      $scope.workshopLink = "#{workshopsUserUrl}/#{$scope.currentWorkshop.id}"

    else
      $scope.currentWorkshop = new Workshop
      $scope.workshopLink = null

  $scope.cancelEdit = ->
    $location.path $scope.workshopsUrl

  $scope.updateWorkshop = (workshop) ->
    workshop.update()
    $location.path $scope.workshopsUrl

  $scope.saveWorkshop = ->
    if $scope.newHost.name
      $scope.currentWorkshop.hosts ||= []
      $scope.currentWorkshop.hosts.push($scope.newHost)

      $scope.newHost = {}

    if $scope.newVideo.link
      $scope.currentWorkshop.videos ||= []
      $scope.currentWorkshop.videos.push($scope.newVideo)
      $scope.newVideo = {}

    if angular.isDefined($scope.currentWorkshop.id)
      $scope.updateWorkshop $scope.currentWorkshop
    else
      $scope.createWorkshop $scope.currentWorkshop
    $scope.currentWorkshop = new Workshop

  $scope.openStartDate = ->
    $scope.startDateOpened = true
])

.controller("hostsCtrl", ['$scope', '$upload', 'hostImageUrl', ($scope, $upload, hostImageUrl) ->
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
  $scope.deleteVideo = (video) ->
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

