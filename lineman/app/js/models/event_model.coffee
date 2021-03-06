angular.module('loomioApp').factory 'EventModel', (BaseModel) ->
  class EventModel extends BaseModel
    @singular: 'event'
    @plural: 'events'
    @foreignKey: 'eventId'

    initialize: (data) ->
      @id = data.id
      @kind = data.kind
      @sequenceId = data.sequence_id
      @commentId = data.comment_id
      @discussionId = data.discussion_id
      @proposalId = data.proposal_id
      @voteId = data.vote_id
      @createdAt = data.created_at
      @actorId = data.actor_id

    serialize: ->
      switch @kind
        when 'new_comment' then @comment()
        when 'new_discussion' then @discussion()
        when 'new_vote' then @vote()
        when 'new_motion' then @proposal()

    discussion: ->
      @recordStore.discussions.get(@discussionId)

    comment: ->
      @recordStore.comments.get(@commentId)

    proposal: ->
      @recordStore.proposals.get(@proposalId)

    vote: ->
      @recordStore.votes.get(@voteId)

    actor: ->
      @recordStore.users.get(@actorId)

    link: ->
      switch @kind
        when 'comment_liked' then "/discussions/#{@comment().discussion().key}##{@commentId}"
