require 'dbi'

columns = ['main_computer_brand','other_operating_system','db_brand','external_storage_sapce_brand']
#              ,                       ,       ,/    ,/

dbh = DBI.connect('dbi:OCI8:jupiterdb.us.oracle.com','kcierpisz','ciapek')

p columns

columns.each do |column_name|
  #sth = dbh.execute("SELECT distinct #{column_name} from sbarsin.fairfax_company_mis_combined")
  sth = dbh.execute("SELECT distinct #{column_name} from sbarsin.fairfax_company_mis_tai")
  i=0
  p "doing... #{column_name}"
  sth.fetch do |row|
    row.each_with_name do |val,name|
      i+=1
      next if val.nil?
      #puts "#{i} val: #{val}"ma
      val_tab = val.split('/').split(',') if val =~ /\/|,/
      #puts "#{val_tab.size}" unless val_tab.nil?
      
      unless val_tab.nil?
        val_tab.each do |el|
          insert_sql = "insert into fairfax_products values('#{column_name}','#{el}',NULL,NULL)"
          dbh.execute(insert_sql)
          #puts "executing: #{insert_sql}"
        end
      else
        insert_sql = "insert into fairfax_products values('#{column_name}','#{val}', NULL, NULL)"
        dbh.execute(insert_sql)
        #puts "executing: #{insert_sql}"
      end
      #dbh.execute(insert_sql)
    end
  end

  dbh.execute('commit')
  sth.finish
end

dbh.disconnect if dbh
