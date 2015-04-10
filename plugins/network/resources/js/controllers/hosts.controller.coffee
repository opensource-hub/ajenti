angular.module('ajenti.network').controller 'NetworkHostsController', ($scope, notify, augeas) ->
    augeas.get('hosts').then (config) ->
        $scope.config = config

    $scope._ = {}

    $scope.addHost = () ->
        path = $scope.config.insert '99', null
        $scope.config.insert path + '/ipaddr', '127.0.0.1'
        $scope.config.insert path + '/canonical', $scope.newHost
        $scope.newHost = ''

    $scope.addAlias = (path) ->
        path = $scope.config.insert path + '/alias', $scope._.newAlias
        $scope._.newAlias = ''

    $scope.save = () ->
        augeas.set('hosts', $scope.config).then () ->
            notify.success 'Saved'
        .catch (e) ->
            notify.error 'Could not save', e.message
