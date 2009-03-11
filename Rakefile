# SQLPORakeFile is Copyright (c) 2009 ProxyObjects
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'sqlite3'
require 'utility_belt/clipboard'
require 'faker'

namespace :db do
  namespace :tables do
    desc "Drop all tables, but not the database"
    task :drop do
      tables.each do |table|
        puts "Dropping #{table}"
        database.execute( "DROP TABLE #{table}" )
      end
    end

    desc "Empty all the tables"
    task :empty do
      tables.each do |table|
        puts "Emptying #{table}"
        database.execute( "DELETE FROM #{table}" )
      end
    end
  end

  desc "Generate fake data for each table in the db `rake db:populate ROWS=x` ROWS=100 by default"
  task :populate do
    rows = (ENV['ROWS'] || 100).to_i

    column_to_type = {}

    tables.each do |table|
      unless table == 'SQLITESEQUENCE'
        schema = database.table_info( table )
        column_to_type[table] = {}
        schema.each do |column|
          name = column['name']
          type = column['type'].downcase.to_sym
          unless name == 'pk'
            case type
            when :real
              if name =~ /date/i || name == 'last_visit' || name == 'birthday'
                # Times within the past 100 days
                column_to_type[table][name] = lambda{ ( Time.now - ( rand * 8640000.0 ) ).strftime( "%Y-%m-%d %H:%M:%S" ) }
              else
                column_to_type[table][name] = lambda{ ( rand * 1000000.0 ) }
              end
            when :integer
              column_to_type[table][name] = lambda{ ( rand * 1000000 ).to_i }
            when :text
              if table == 's_q_l_p_o_tests_pet' && name == 'groomer'
                # Associate a random groomer with this pet
                column_to_type[table][name] = lambda{ "SQLPOTestsGroomer-#{(rand * rows).to_i + 1}" }
              elsif table == 's_q_l_p_o_tests_pet' && name == 'owner'
                # Associate a random owner with this pet
                column_to_type[table][name] = lambda{ "SQLPOTestsPerson-#{(rand * rows).to_i + 1}" }
              elsif name =~ /name/i
                column_to_type[table][name] = lambda{ Faker::Name.name }
              else
                column_to_type[table][name] = lambda{ Faker::Company.name }
              end
            when :blob
              # do nothing
              # FIXME: should check to see if this column is not null.  Add an empty string if so?
            else
              # Default to empty string
              column_to_type[table][name] = lambda{ '' }
            end
          end
        end
      end
    end

    ['s_q_l_p_o_tests_groomer', 's_q_l_p_o_tests_person', 's_q_l_p_o_tests_pet'].each do |table|
      columns = column_to_type[table]
      sql = "INSERT INTO #{table} (#{columns.keys.sort.join(', ')}) VALUES (#{columns.keys.map{ '?' }.join(', ')})"
      statement = database.prepare( sql )
      ( table == 's_q_l_p_o_tests_pet' ? 10 * rows : rows ).times do
        values = columns.keys.sort.map {|k| column_to_type[table][k].call }
        statement.bind_params( *values )
        statement.execute
      end
      puts "Populated #{table}"
    end
  end

  desc "Show the path to the database file"
  task :path do
    puts database_path
  end

  namespace :path do
    desc "Show and copy the path to the database file"
    task :copy do
      Rake::Task['db:path'].invoke
      require 'utility_belt'
      UtilityBelt
      UtilityBelt::Clipboard.write( database_path )
    end
  end

  desc "Show all tables"
  task :tables do
    puts "Tables in the database:\n-----------------------"

    max_length = tables.inject( 0 ) do |max,t|
      max = t.length if t.length > max
      max
    end

    tables.each do |table|
      count = database.execute( "SELECT COUNT( * ) FROM #{table}")
      puts "%-#{max_length}s (count = #{count})" % table
    end
  end


  desc "Show all indices"
  task :indices do
    puts "INDICES"
    statement = database.prepare( "SELECT * FROM sqlite_master WHERE type = 'index'" )
    rows = [statement.columns]
    statement.execute.each do |row|
      rows << row
    end
    display_tabular_data( rows )
  end


  desc "CAUTION! Execute a SQL statement"
  task :execute do
    begin
      statement = database.prepare( ENV['SQL'] )
      rows = [statement.columns]
      statement.execute.each do |row|
        rows << row
      end
      display_tabular_data( rows )
    rescue Exception => e
      puts "#{e.message}."
    end
  end

  desc "Invoke sqlite3 on the database"
  task :shell do
    system "sqlite3 '#{database_path}'"
  end

  desc "Show table schemas"
  task :schema do
    headers = [ 'COL', 'NAME', 'TYPE', 'NOT NULL', 'DEFAULT', 'PK' ]

    tables.each do |table|
      puts "TABLE: #{table}"

      table_schema = database.execute( "PRAGMA table_info( #{table} )")
      table_schema.unshift( headers )

      display_tabular_data( table_schema )
    end

    Rake::Task['db:indices'].invoke
  end
end

def display_tabular_data( rows )
  column_widths = rows.inject( rows.first.map{ |c| c.length } ) do |max,column_info|
    column_info.each_with_index do |d,i|
      max[i] = d.to_s.length if d.to_s.length > max[i].to_i
    end
    max
  end

  print_line( :type => 'border', :column_widths => column_widths )
  rows.each_with_index do |column_info,i|
    print_line( :columns => column_info, :column_widths => column_widths )
    print_line( :type => 'border', :column_widths => column_widths ) if i.zero?
  end
  print_line( :type => 'border', :column_widths => column_widths )
  print "\n\n"
end

def print_line( o = {} )
  column_widths = o[:column_widths]

  case o[:type]
  when 'border'
    column_widths.each_with_index do |w,i|
      print "+-#{'-' * column_widths[i]}-"
    end
    puts "+"
  else
    columns = o[:columns]

    columns.each_with_index do |l,i|
      print "| %-#{column_widths[i].to_i}s " % l
    end
    puts "|"
  end
end

def tables
  @tables ||= database.execute( "SELECT name FROM sqlite_master WHERE type = 'table'" ).map { |t| t.first }.sort!
end

def database_path( database_filename=nil )
  if database_filename.nil?
    xcode_info = `xcodebuild -list 2> /dev/null`.split( /^\s*Targets:$/ )[1]
    xcode_info.split( "\n" ).each do |line|
      if line =~ /^\s*([^\s].*) \(Active\)$/
        database_filename = "#{$1.gsub( / /, '' ).downcase}.sqlite3"
        break
      end
    end
  end

  @db_path ||= Dir.glob( "/Users/#{`whoami`.chomp}/Library/Application Support/iPhone Simulator/User/Applications/**/Documents/#{database_filename}" ).first
end

def database( database_filename=nil )
  @db ||= SQLite3::Database.new( database_path( database_filename ) )
rescue
  puts "COULD NOT LOCATE THE DATABASE FILE"
  nil
end
