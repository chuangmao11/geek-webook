local key = KEYS[1]

local window = tonumber(ARGV[1])
--阈值
local threshold = tonumber(ARGV[2])

local now = tonumber(ARGV[3])
-- 计算窗口的起始时间
local min = now - window
-- 对ZSET进行操作，移除范围以外的元素
redis.call('ZREMRANGEBYSCORE', key, '-inf', min)
-- 统计请求数量
local cnt = redis.call('ZCOUNT', key, '-inf', '+inf')

if cnt >= threshold then
    return "true"
else
-- 第一个score是score，表示请求的时间戳，第二个表示成员
    redis.call('ZADD', key, now, now)
    redis.call('PEXPIRE', key, window)
    return "false"
end