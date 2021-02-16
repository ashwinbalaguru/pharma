# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# xlsx = Roo::Spreadsheet.open('/Users/ashwinbalaguru/Downloads/Amara Generic.xlsx')

xlsx.each_with_pagename do |sheet|
  str = sheet[1].row(1)[0]
  category = CGI::unescapeHTML(str.gsub(/<\/?[^>]*>/,"")).downcase

  sheet[1].each do |row|
    med = MedDetail.new(category: category)

    next if row[1].nil? || row[1] == "<html><b>Name of the Salt</b></html>"
    salt = row[1].gsub("\n",'').downcase
    med.salt = salt


    next if row[2].nil? || row[2] == "<html><b>Unit\n</b><b>Size</b></html>" ||
            row[2] == "<html><b>Unit Size</b></html>" || row[2] == "Unit\nSize"

    val, med_type = process_value(row)
    med.unit = val
    med.med_type = med_type



    next if row[3].nil? || row[3] == "<html><b>BPPI\n</b><b>MRP</b></html>" ||
            row[3] == "BPPI\nMRP" || row[3] == "<html><b>BPPI MRP</b></html>"
    actual_price = row[3].to_f
    med.price = actual_price



    next if row[4].nil? || row[4] == "<html><b>Average MRP of top 3 leading brands</b></html>" ||
            row[4] == "Average MRP of top 3 leading brands" || row[4] == "<html><b>Average MRP of top 3\n</b><b>leading brands</b></html>"
    avg_market_price = row[4].to_f
    med.avg_market_price = avg_market_price

    med.save
  end
end


def process_value(row)
  if row[2].include? '\'s'
    val = row[2].gsub('\'s', '') + "'s"
    med_type = 'caps'

  elsif (row[2].downcase.include? 'wfi')
    if row[2].include? "\n"
      row[2] = row[2].gsub("\n", '')
    end
    val = row[2].downcase
    med_type = 'vial_wfi'

  elsif (row[2].downcase.include? 'vial')
    val = row[2].gsub('vial', '').strip
    med_type = 'vial'

  elsif (row[2].include? 'ml')
    val = row[2].scan(/\d/).join + 'ml'
    med_type = 'syrup'

  elsif (row[2].include? 'gm')
    val = row[2].scan(/\d/).join + 'gm'
    med_type = 'gm'
  end

  return val, med_type
end


-------------------------------

----SKIN-----


# xlsx = Roo::Spreadsheet.open('/Users/ashwinbalaguru/Downloads/Amara - Skin.xlsx')

xlsx.each_with_pagename do |sheet|
  str = sheet[1].row(1)[0]
  category = CGI::unescapeHTML(str.gsub(/<\/?[^>]*>/,"")).downcase

  sheet[1].each do |row|
    med = MedDetail.new(category: category)

    next if row[1].nil? || row[1] == "<html><b>Name of the Salt</b></html>"
    salt = row[1].gsub("\n",'').downcase
    med.salt = salt


    next if row[2].nil? || row[2] == "<html><b>Unit\n</b><b>Size</b></html>" ||
            row[2] == "<html><b>Unit Size</b></html>" || row[2] == "Unit\nSize"

    val, med_type = process_value(row)
    med.unit = val
    med.med_type = med_type



    next if row[3].nil? || row[3] == "<html><b>BPPI\n</b><b>MRP</b></html>" ||
            row[3] == "BPPI\nMRP" || row[3] == "<html><b>BPPI MRP</b></html>"
    actual_price = row[3].to_f
    med.price = actual_price



    next if row[4].nil? || row[4] == "<html><b>Average MRP of top 3 leading brands</b></html>" ||
            row[4] == "Average MRP of top 3 leading brands" || row[4] == "<html><b>Average MRP of top 3\n</b><b>leading brands</b></html>"
    avg_market_price = row[4].to_f
    med.avg_market_price = avg_market_price

    med.save
  end
end


def process_value(row)
  if row[2].include? '\'s'
    val = row[2].gsub('\'s', '') + "'s"
    med_type = 'caps'

  elsif (row[2].include? 'Cream')
    val = row[2].scan(/\d/).join + 'gm'
    med_type = 'cream'

  elsif (row[2].include? 'Power')
    val = row[2].scan(/\d/).join + 'gm'
    med_type = 'power'

  elsif (row[2].include? 'Lotion')
    val = row[2].scan(/\d/).join + 'ml'
    med_type = 'lotion'

  elsif (row[2].include? 'ml')
    val = row[2].scan(/\d/).join + 'ml'
    med_type = 'lotion'

  elsif (row[2].include? 'gm')
    val = row[2].scan(/\d/).join + 'gm'
    med_type = 'gm'

  elsif (row[2].include? 'Container')
    val = 'container'
    med_type = 'container'
  end

  return val, med_type
end
