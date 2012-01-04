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
      '1.1K'  => 1160,
      '2K'    => 2050,
      '19.5K' => 20000,
      '20K'   => 20490,
      '100K'  => 100*2**10,
      '102K'  => 100*1024+1200,
      '935K'  => 957383,
      '1M'    => 1024*1024,
      '1M'    => 1024*1024-100,
      '1M'    => 1024*1024+100,
      '1.1M'  => 1024*1024+150*1024,
      '6.5M'  => 6809954,
      '71M'   => 74046302,
      '242M'  => 253012972,
      '1.4G'  => 1471936825,
      '20G'   => 1024**3*20,
      '1.5T'  => 1024**4*1.5,
    }.each do |expected, num|
      assert_equal expected, MF60::Helpers.bytes_formatted(num)
    end
  end
    
end