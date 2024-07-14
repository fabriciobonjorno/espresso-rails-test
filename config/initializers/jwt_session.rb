# frozen_string_literal: true

JWTSessions.signing_key = '0azBzn5PuJN6PSqukriK8Q'
JWTSessions.algorithm = 'HS256'
JWTSessions.access_exp_time = 3600 # 1 hour in seconds
JWTSessions.refresh_exp_time = 604_800 # 1 week in seconds
JWTSessions.access_cookie = 'access_token'
