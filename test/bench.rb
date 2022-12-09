require "benchmark/ips"

Benchmark.ips do |bench|
  # TODO: Restore this functionality
  bench.report "running m on a file that doesn't exist" do
    `ruby -Ilib ./bin/m failwhale 2>/dev/null`
  end

  bench.report "running m on an empty file" do
    `ruby -Ilib ./bin/m test/examples/empty_example_test.rb 2>/dev/null`
  end

  bench.report "running m on an entire file with minitest4" do
    `bundle exec rake test:minitest4 TEST=test/examples/minitest_4_example_test.rb 2>/dev/null`
  end

  bench.report "running m on an entire file with minitest5" do
    `bundle exec rake test:minitest5 TEST=test/examples/minitest_5_example_test.rb 2>/dev/null`
  end

  bench.report "running m on an entire file with test-unit gem" do
    `bundle exec rake test:test_unit_gem TEST=test/examples/test_unit_example_test.rb 2>/dev/null`
  end

  bench.report "running m on a specific test with minitest4" do
    `bundle exec rake test:minitest4 TEST=test/examples/minitest_4_example_test.rb 2>/dev/null`
  end

  bench.report "running m on a specific test with minitest5" do
    `bundle exec rake test:minitest5 TEST=test/examples/minitest_5_example_test.rb 2>/dev/null`
  end

  bench.report "running m on a specific test with test-unit gem" do
    `bundle exec rake test:test_unit_gem TEST=test/examples/test_unit_example_test.rb 2>/dev/null`
  end
end
