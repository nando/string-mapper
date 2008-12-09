require File.expand_path(File.dirname(__FILE__)) + '/../lib/string-mapper'
require 'spec'

describe 'String mapper' do
  it 'should translate from regular expresions, strings and symbols' do
    # regexp...
    String.add_mapper(:number)
    String.number_mappings[/un[ao]?$/i] = 1 
    %{un una uno UN UNA UNO}.each do |numero| 
      numero.to_number.should == 1
    end
    # string...
    String.number_mappings['dos'] = 2
    'DoS'.to_number.should == 2
    'DOS'.to_number.should == 2
    # symbol
    String.number_mappings[:tres] = 3
    'TRES'.to_number.should == 3
    'Tres'.to_number.should == 3
  end

  it 'should receive a block when defined that should be used for default values (not mapped)' do
    String.add_mapper(:number) { |str| str.to_i }
    '1000'.to_number.should == 1000
    'ningún'.to_number.should == 0
  end
end
