-- Remove job from reliability queue
redis.call("LREM", KEYS[2], 0, ARGV[3])
redis.call("ZREM", KEYS[3], ARGV[3])

-- Add job and its fail time (score) to failed sorted set
redis.call("ZADD", KEYS[1], ARGV[1], ARGV[2])

-- Remove any jobs that have been given up long enough ago (their score is
-- below given value)
redis.call("ZREMRANGEBYSCORE", KEYS[1], "-inf", ARGV[4])
