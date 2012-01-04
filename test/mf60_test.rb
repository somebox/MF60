require 'test/unit'
require 'mf60'

class MF60Test < Test::Unit::TestCase
  def test_bytes_formatted
    {
      '-'     => 0,
      '1B'    => 1, 
      '100B'  => 100,
      '589B'  => 589,
      '1K'    => 1024,
      '1.1K'  => 1110,
      '2K'    => 2050,
      '19K'   => 20000,
      '20K'   => 20490,
    }.each do |expected, num|
      assert_equal expected, MF60::Helpers.bytes_formatted(num)
    end
  end
    
end