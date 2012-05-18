# Cosm OAuth

[![Build Status](https://secure.travis-ci.org/smulube/cosm_oauth.png)](http://travis-ci.org/smulube/cosm_oauth)

Simple little library for accessing the [Cosm](https://cosm.com) api via OAuth.

Currently handles obtaining an access_token using OAuth 2 server flow.

Also exposes a very minimal little HTTP api for speaking to Cosm. Just returns
strings containing responses, which can then be parsed accordingly.

## Usage

For an example app that demonstrates the use of this gem to obtain an
access_token please see the demo app currently running at
http://cosm-oauth-example.herokuapp.com, or view the source of that app at
https://github.com/smulube/cosm_oauth_demo
