function pprof
  go tool pprof -http=localhost:8083 http://localhost:6060/debug/pprof/$argv
end
