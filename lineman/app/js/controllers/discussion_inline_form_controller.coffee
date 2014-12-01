angular.module('loomioApp').controller 'DiscussionInlineFormController', ($scope, FormService, DiscussionService) ->
  FormService.applyForm $scope, DiscussionService.save, $scope.discussion

  $scope.finish = -> $scope.$root.$broadcast 'editInlineComplete'
  $scope.onSuccess = $scope.finish
  $scope.cancel = ($event) ->
    $event.preventDefault()
    $scope.finish()