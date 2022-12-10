require 'benchmark/ips'

Benchmark.ips do |bench|
  bench.report("running m on a file that doesn't exist") do
    `bundle exec ruby -Ilib ./bin/m failwhale 2>/dev/null`
  end

  bench.report("running m on an empty file") do
    `bundle exec ruby -Ilib ./bin/m test/examples/empty_example_test.rb 2>/dev/null`
  end

  bench.report("running m on an entire file with minitest4") do
    `BUNDLE_GEMFILE=gemfiles/minitest4.gemfile bundle exec ruby -Ilib ./bin/m test/examples/minitest_4_example_test.rb 2>/dev/null`
  end

  bench.report("running m on an entire file with minitest5") do
    `BUNDLE_GEMFILE=gemfiles/minitest5.gemfile bundle exec ruby -Ilib ./bin/m test/examples/minitest_5_example_test.rb 2>/dev/null`
  end

  bench.report("running m on an entire file with test-unit gem") do
    `BUNDLE_GEMFILE=gemfiles/test_unit_gem.gemfile bundle exec ruby -Ilib ./bin/m test/examples/test_unit_example_test.rb 2>/dev/null`
  end

  bench.report("running m on a specific test with minitest4") do
    `BUNDLE_GEMFILE=gemfiles/minitest4.gemfile bundle exec ruby -Ilib ./bin/m test/examples/minitest_4_example_test.rb:19 2>/dev/null`
  end

  bench.report("running m on a specific test with minitest5") do
    `BUNDLE_GEMFILE=gemfiles/minitest5.gemfile bundle exec ruby -Ilib ./bin/m test/examples/minitest_5_example_test.rb:19 2>/dev/null`
  end

  bench.report("running m on a specific test with test-unit gem") do
    `BUNDLE_GEMFILE=gemfiles/test_unit_gem.gemfile bundle exec ruby -Ilib ./bin/m test/examples/test_unit_example_test.rb:15 2>/dev/null`
  end
end
