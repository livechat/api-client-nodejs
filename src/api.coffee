request = require 'request'
crypto = require 'crypto'

class Requester
	constructor: (@user, @apiKey, @apiVersion = 2, @host = 'https://api.livechatinc.com/') ->
		@request = request.defaults
						auth:
							user: @user
							password: @apiKey
						headers:
							'X-API-Version': @apiVersion

	get: (method, data = {}, callback) =>
		@request
			url: @host + method
			qs: data
		, ( error, response, body) =>
			if error?
				callback { error: error }
			else
				if response.statusCode == 200
					try
						callback JSON.parse body
					catch error
						callback { error: error, body: body }
				else
					callback { error : body }

	post: (method, data = {}, callback) =>
		@request.post
			url: @host + method
			form: data
		, ( error, response, body) =>
			if error?
				callback { error: error }
			else
				if response.statusCode == 200
					try
						callback JSON.parse body
					catch error
						callback { error: error, body: body }
				else
					callback { error : body }

	put: (method, data = {}, callback) =>
		@request.put
			url: @host + method
			form: data
		, ( error, response, body) =>
			if error?
				callback { error: error }
			else
				if response.statusCode == 200
					try
						callback JSON.parse body
					catch error
						callback { error: error, body: body }
				else
					callback { error : body }

	del: (method, data = {}, callback) =>
		@request.del
			url: @host + method
			form: data
		, ( error, response, body) =>
			if error?
				callback { error: error }
			else
				if response.statusCode == 200
					try
						callback JSON.parse body
					catch error
						callback { error: error, body: body }
				else
					callback { error : body }

class BasicCrud
	constructor: (@api, @path) ->

	list: (params= {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path, params, (response) =>
			if callback?
				callback response

	get: (id = '', callback) =>
		@api.get @path + '/' + id, {}, (response) =>
			if callback?
				callback response

	create: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.post @path, params, (response) =>
			if callback?
				callback response

	update: (id = '', params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.put @path + '/' + id, params, (response) =>
			if callback?
				callback response

	delete: (id = '', callback) =>
		@api.del @path + '/' + id, {}, (response) =>
			if callback?
				callback response

class Agents extends BasicCrud
	constructor: (@api) ->
		super @api, 'agents'

	resetApiKey: (id = '', callback) =>
		@api.put 'agents/' + id + '/reset_api_key', {}, (response) =>
			if callback?
				callback response

class Operators extends BasicCrud
	constructor: (@api) ->
		super @api, 'operators'

class CannedResponses extends BasicCrud
	constructor: (@api) ->
		super @api, 'canned_responses'

class Chats extends BasicCrud
	constructor: (@api) ->
		super @api, 'chats'

		delete @.create
		delete @.update
		delete @.delete

	send: (id, params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.post 'chats/' + id + '/send_transcript', params, (response) =>
			if callback?
				callback response

class Goals extends BasicCrud
	constructor: (@api) ->
		super @api, 'goals'

	mark: (id, params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.post 'goals/' + id + '/mark_as_successful', params, (response) =>
			if callback?
				callback response

class Greetings extends BasicCrud
	constructor: (@api) ->
		super @api, 'greetings'

class Groups extends BasicCrud
	constructor: (@api) ->
		super @api, 'groups'

class OfflineMessages extends BasicCrud
	constructor: (@api) ->
		super @api, 'offline_messages'

		delete @.create
		delete @.update
		delete @.delete

class ReportsV1
	constructor: (@api) ->
		@path = 'reports'

	getChatsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/chats', params, (response) =>
			if callback?
				callback response

	getInvitationsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/invitations', params, (response) =>
			if callback?
				callback response


class Reports
	constructor: (@api) ->
		@path = 'reports'

	getDashboardData: (callback) =>
		@api.get @path + '/dashboard', {}, (response) =>
			if callback?
				callback response

	getDashboardDataForAgent: (id, callback) =>
		@api.get @path + '/dashboard/agent/' + id, {}, (response) =>
			if callback?
				callback response

	getDashboardDataForGroup: (id, callback) =>
		@api.get @path + '/dashboard/group/' + id, {}, (response) =>
			if callback?
				callback response

	getChatsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/chats', params, (response) =>
			if callback?
				callback response

	getRatingsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/ratings', params, (response) =>
			if callback?
				callback response

	getRatingsRanking: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/ratings/ranking', params, (response) =>
			if callback?
				callback response

	getQueuedVisitorsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/queued_visitors', params, (response) =>
			if callback?
				callback response

	getQueueWaitingTimesReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/queued_visitors/waiting_times', params, (response) =>
			if callback?
				callback response

	getAvailabilityReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/availability', params, (response) =>
			if callback?
				callback response

	getChattingTimeReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/chatting_time', params, (response) =>
			if callback?
				callback response

	getGoalsReport: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path + '/goals', params, (response) =>
			if callback?
				callback response

class Status
	constructor: (@api) ->

	get: (params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get 'status', params, (response) =>
			if callback?
				callback response

class Visitors
	constructor: (@api) ->
		@path = 'visitors'

	list: (params= {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.get @path, params, (response) =>
			if callback?
				callback response

	listOnlyChattingVisitors: (callback) =>
		@api.get @path + '/chatting', {}, (response) =>
			if callback?
				callback response

	addCustomVisitorDetails: (id, params = {}, callback) =>
		if typeof params == 'function' and !callback?
			callback = params
			params = {}

		@api.post @path + '/' + id + '/details', params, (response) =>
			if callback?
				callback response

class Skills extends BasicCrud
	constructor: (@api) ->
		super @api, 'skills'

class PushPages extends BasicCrud
	constructor: (@api) ->
		super @api, 'push_pages'

class TrackingCode
	constructor: (@api) ->
		@path = 'tracking_code'

	get: (callback) =>
		@api.get @path + '/', {}, (response) =>
			if callback?
				callback response

class ButtonCode
	constructor: (@api) ->
		@path = 'button_code'

	get: (callback) =>
		@api.get @path + '/', {}, (response) =>
			if callback?
				callback response



class LiveChatApi extends Requester
	constructor: (@user, @apiKey, @apiVersion = 2, @host = 'https://api.livechatinc.com/') ->
		super @user, @apiKey, @apiVersion, @host

		if @apiVersion == 2
			@agents = new Agents(@) # 2
			@groups = new Groups(@) # 2
			@reports = new Reports(@) # @ 2
			@greetings = new Greetings(@) # 2
		else if @apiVersion == 1
			@operators = new Operators(@) # 1
			@offline_messages = new OfflineMessages(@) # 1
			@skills = new Skills(@) # 1
			@push_pages = new PushPages(@) # 1
			@tracking_code = new TrackingCode(@) # 1
			@button_code = new ButtonCode(@) # 1
			@reports = new ReportsV1(@)

		@canned_responses = new CannedResponses(@) # 2 & 1
		@chats = new Chats(@) # 2 & 1
		@goals = new Goals(@) # 2 & 1
		@status = new Status(@) # 2 & 1
		@visitors = new Visitors(@) # 2 & 1


exports.LiveChatApi = LiveChatApi
