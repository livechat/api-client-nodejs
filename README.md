# LiveChat API

## Installation

Module available through NPM and can be installed with command `npm install livechatapi`

## Quick start

Module designed to completely repeat official API without needs to think about authentication.

```
var LiveChatApi = require('livechatapi').LiveChatApi;
var api = new LiveChatApi('username@domain.com', 'APIKEY')
api.status.get({ group: 0 }, function(data){
  console.log(data);
});
```

If you need to call function with default parameters you can call it without `parameters`. Above function could be simplified to

```
api.status.get(function(data){
  console.log(data);
});
```

If you don't need function results you can skip `callback` function definition. For example new agent creation can be done with this code

```
api.agents.create({ login: 'philip.j.fry@planetexpress.com', name: 'Philip J. Fry' })
```

## API Methods List

Full description of methods parameters available at [LiveChat RESTful API Documentation](http://developers.livechatinc.com/rest-api/) page.

> Library has [API V1](http://www.livechatinc.com/api/v1/) support but as this version is deprecated it's not described in list. Most part of functions calls are similar to V2. For example, list of operators could be asked with simple api.operators.list() call.

### Agents

#### api.agents.list(parameters, callback)

Returns all LiveChat agents list.

#### api.agents.get(login, callback)

Return complete details of the agent for the given login.

#### api.agents.create(parameters, callback)

Creates a new agent in your license.

#### api.agents.update(login, parameters, callback)

Updates the specified agent by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

#### api.agents.resetApiKey(login, callback)

Reset API key for the agent with given login.

#### api.agents.delete(login, callback)

Removes an agent. Archived chats will not be removed, but all statistics will be lost. Agent will be notified by e-mail that the account has been deleted.


### Canned Responses

#### api.canned_responses.list(parameters, callback)

Returns list of all currently set canned responses.

#### api.canned_responses.get(id, parameters, callback)

Get single canned response. `id` is obtained from the all canned responses list.

#### api.canned_responses.create(parameters, callback)

Creates a new canned response.

#### api.canned_responses.update(id, parameters, callback)

Updates the specified canned response by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

#### api.canned_responses.delete(id, callback)

Removes a canned response with the given `id`.


### Chats

#### api.chats.list(parameters, callback)

Returns all ended chats.

#### api.chats.get(id, parameters, callback)

Returns single chat item for the given `id`.

#### api.chats.send(id, parameters, callback)

Send chat transcript to e-mail.


### Goals

#### api.goals.list(parameters, callback)

Returns all currently set goals.

#### api.goals.get(id, parameters, callback)

Returns goal details for the given `id`.

#### api.goals.create(parameters, callback)

Creates new goal.

#### api.goals.update(id, parameters, callback)

Updates the specified goal by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

#### api.goals.delete(id, callback)

Removes a goal with the given `id`.

#### api.goals.mark(id, params, callback)

Mark goal as successful.


### Groups

#### api.groups.list(parameters, callback)

Returns all created groups.

#### api.groups.get(id, parameters, callback)

Returns group details for the given `id`.

#### api.groups.create(parameters, callback)

Creates a new group in your license.

#### api.groups.update(id, parameters, callback)

Updates the specified group by setting the values of the parameters passed. Any parameters not provided will be left unchanged.

#### api.groups.delete(id, callback)

Removes a group with the given `id`.

### Reports

#### api.reports.getDashboardData(callback)

Returns statistics overview from last 7 days for the whole license.

#### api.reports.getDashboardDataForAgent(login, callback)

Returns statistics overview from last 7 days for the specified agent. Shows his ratings, number of chats and number of reached goals. `login` must be correct e-mail address.

#### api.reports.getDashboardDataForGroup(id, callback)

Returns statistics overview from last 7 days for the specified group. Shows ratings, number of chats and reached goals. `id` is obtained from all groups list.

#### api.reports.getChatsReport(params, callback)

Shows how many chats and missed chats (offline messages) occurred during the specified period.

#### api.reports.getRatingsReport(params, callback)

Shows how many chats were rated and how they have been rated during specified period.

#### api.reports.getRatingsRanking(params, callback)

Shows the ratio of good to bad ratings for each operator.

#### api.reports.getQueuedVisitorsReport(params, callback)

Shows how many visitors were waiting in the queue, how many abandoned the queue or proceeded to chats.

#### api.reports.getQueueWaitingTimesReport(params, callback)

Shows Minimum, Average and Maximum waiting time.

#### api.reports.getAvailabilityReport(params, callback)

Shows how much the agent (or group or whole account) was available for chatting during specified period. When querying for one day results are shown in minutes per every hour, otherwise in hours for each day.

#### api.reports.getChattingTimeReport(params, callback)

Shows how much time the agent (or group) spent on chatting during specified period. When querying for one day results are shown in minutes per every hour, otherwise in hours for each day.

#### api.reports.getGoalsReport(params, callback)

Shows the number of reached goals.

### Status

### api.status.get(parameters, callback)

Returns current LiveChat status.

### Visitors

### api.visitors.list(callback)

Returns list of the visitors available on pages with tracking code installed.

### api.visitors.listOnlyChattingVisitors(callback)

Returns list of currently chatting visitors.

### api.visitors.addCustomVisitorDetails(id, parameters, callback)

Displays additional information about the visitor in LiveChat apps. Detailed explaination available on [API documentation page](http://developers.livechatinc.com/rest-api/#add-custom-visitor-details).
