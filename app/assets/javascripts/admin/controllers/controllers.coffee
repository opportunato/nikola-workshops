angular.module("nikolaWorkshopsAdmin")
.controller("adminCtrl", ($scope, $location, Workshop, workshopsUrl) ->
  $scope.workshopsUrl = workshopsUrl
  $scope.data = {}

  $scope.createWorkshop = (workshop) ->
    new Workshop(workshop).create().then (newWorkshop) ->
      $scope.data.workshops.push newWorkshop
      $location.path $scope.workshopsUrl

  $scope.deleteWorkshop = (workshop) ->
    workshop.$delete().then ->
      $scope.data.workshops.splice $scope.data.workshops.indexOf(workshop), 1

    $location.path $scope.workshopsUrl
)

.controller("workshopsTableCtrl", ($scope, $location, $route, workshops) ->
  $scope.data.workshops = workshops
)

.controller "workshopsEditCtrl", ($scope, $routeParams, $location, workshops, Workshop) ->
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

.controller "hostsCtrl", ($scope, $routeParams, $location) ->
  $scope.newHost = {}

  $scope.deleteHost = (host) ->
    hosts = $scope.currentWorkshop.hosts
    hosts.splice hosts.indexOf(host), 1

  $scope.addHost = ->
    $scope.currentWorkshop.hosts.push($scope.newHost)
    $scope.newHost = {}
