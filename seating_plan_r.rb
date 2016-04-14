class Seating


	#implementation in the website
	# All inputs would be done by forms
	# This page would be a helper
	# all functions can be called by the view
	#implement a saving strategy
	# backup student details to a file 
	# Create a flow chart of this program before implementing to website



	def initialize()
		# 0 are available seats.
		puts "Enter the max width of seats, as in max amount of seats in one plane"
		@seats_x = gets.strip.to_i +1
		puts "Enter array Height of seats"
		@seats_y = gets.strip.to_i + 1
		puts 'Enter number of available seats'
		@available_seats = gets.strip.to_i

		@no_seat = "\u25CB"
		@yes_seat = "\u25C9"
		if @available_seats >= @seats_x * @seats_y
			"error"
		else
			"continue"
		end
	end

	def class_layout
		row_array = []
		seat_array =  []
		index_row = []
	    for y in (0..@seats_y-1)
		    for x in  (0..@seats_x-1)
		    	index_row << x + 1     
		        row_array << @no_seat
		    end
		    seat_array << row_array
		    row_array = []
		end
		print_layout(seat_array)
		seat_array
	end

	def seat_layout(new_layout)
		
		for i in 0..(@available_seats-1)
			puts "Enter seat layout"
			puts "#{i+1}: Enter Position for an available seat Example: B5"
			position = gets.strip
			if position.length == 2 
				x_pos = ( position[1].to_i - 1 )
				y_pos = letter_to_num(position[0].upcase)
				if new_layout[y_pos][x_pos] == @yes_seat
					puts "Already used please do again"
					i -= 1
				else
					new_layout[y_pos][x_pos] = @yes_seat
				end
			else
				"incorrect Info"
			end
			print_layout(new_layout)
		end
		print(new_layout)
		puts
		new_layout
	end

	def algorithm(new_layout, s_list_copy)
		#loud students to not be put next to another loud student, / put closer to the front.
		# needing students put on the front.
		# student cannot sit next to their problem partner
		# Everything else fills up the other rows.
		# Fill up so that the back should not be filled.
			# student_list = student_list_data
			# new_list = student_list.sort_by(level_learning)
			# new_list = student_list.map{|student| student.level_learning == 1}
			# student_list.sort_by(noise)
			# student_list.each do |student|
			# 	if student.noise == 3
			# 		#do not put directly next to a studentnoise level of 2/3
			# 		#and put minimum of 3 spaces away from another noise 3 student
			# 	end
			# 	#if seat layout has no more spaces, then allow to be put in the first available empty space. 
			# end

		# new_layout = seat_layout.dup
		# s_list = student_list_data
		# s_list_copy = s_list.dup
		print(s_list_copy)
		puts

		s_list_copy = s_list_copy.sort_by{|k,v| v["level"]}

		print(s_list_copy)
		puts

		# Alternating to boy girl
		#pre requesite questions 
		puts "Do you want the seating plan to have boy girl layout?  y/n"
		male_female = gets.strip.upcase
		puts "Does noise level of students matter? y/n"
		noise_question = gets.strip.upcase
		if male_female == "Y"
			loopy = true
			gender_loop = "M"
			new_s_list = []
	
			while loopy == true
				i = 0
				loopy2 = true
				while loopy2 == true
					if gender_loop == "M"
						if s_list_copy[i][1]["gender"] == "M"
							new_s_list << s_list_copy[i]
							s_list_copy.delete_at(i)
							loopy2 = false
						else
							i += 1
							gender_loop = "F"
						end
					else
						if s_list_copy[i][1]["gender"] == "F"
							new_s_list << s_list_copy[i]
							s_list_copy.delete_at(i)		
							loopy2 = false
						else
							i += 1
							gender_loop = "M"
						end
					end
				end
				if gender_loop == "M"
					gender_loop = "F"
				else 
					gender_loop = "M"
				end
				if s_list_copy.empty? == true 
					loopy2 = false
					loopy = false
				end
			end
		else
			new_s_list = s_list_copy
		end
		new_s_list = new_s_list.to_h
		print(new_s_list)
		puts

		# check for first available seats, row by row, then column by column
		@coord = []
		
		for y in 0..@seats_y-1
			for x in 0..@seats_x -1
				if new_layout[y][x] == @yes_seat
					@coord << [x,y]
				end
			end
		end

		print @coord 
		puts 
		student_num = 1
		new_array_s_list = new_s_list.to_a.dup
		while (not(new_array_s_list.length <= 0) && @coord.length >= 0 )

			id = new_array_s_list[0][0]
			whitelist = new_s_list[id]["whitelist"]
			puts whitelist

			name = new_s_list[id]["name"]
			puts name
		
			x_pos = @coord[0][0]
			y_pos = @coord[0][1]
			

			#make it so that to the right, to the left, to the up, to the down are all checked, and are in 1 space.
			#diagonal counts as 2 grid spaces
			#sort so that level is #1 priority
			#then arranges that into gender
			# then arranges that into whitelists
			#then arranges by noise
			#continue this for the level 2 
			# then with 4
			#any spaces left over, allows for a level 2 to go then a level 3
			# row from A is where priority should go
			#then all the way to Z
		

			#positional data for array
			pos_right =new_layout[y_pos][x_pos+1].to_s
			pos_left = new_layout[y_pos][x_pos-1].to_s
			pos_up = new_layout[y_pos-1][x_pos].to_s
			pos_down = new_layout[y_pos+1][x_pos].to_s
			pos_ne = new_layout[y_pos-1][x_pos+1].to_s
			pos_nw = new_layout[y_pos-1][x_pos-1].to_s
			pos_sw = new_layout[y_pos+1][x_pos-1].to_s
			pos_se = new_layout[y_pos+1][x_pos+1].to_s

			#starting condition
			to_place = [true]

			# puts ("#{pos_right},#{pos_left},#{pos_up},#{pos_down},#{pos_ne},#{pos_nw},#{pos_sw}, #{pos_se}")
			puts 'up!!!'
			puts pos_up 
			puts "s list up"
			puts new_s_list[pos_up]
			if (x_pos != 0 && x_pos != @seats_x && y_pos != 0 && y_pos != @seats_y)
				if new_s_list[pos_left] == nil && new_s_list[pos_right] == nil && new_s_list[pos_down] == nil && new_s_list[pos_up] == nil && new_s_list[pos_nw] == nil && new_s_list[pos_ne] == nil && new_s_list[pos_se] == nil && new_s_list[pos_sw] == nil 
					puts "nothing around"
					to_place = true
				else
					if new_s_list[pos_right] != nil
						puts "r"
						if new_s_list[pos_right]["name"] == whitelist || new_s_list[pos_right]["whitelist"] == name
							puts "right"
							to_place << false
							
						end
					end
					if new_s_list[pos_left] != nil
						puts "l"
						if new_s_list[pos_left]["name"] == whitelist || new_s_list[pos_left]["whitelist"] == name
							puts "left"
							to_place << false
							
						end
					end
					if new_s_list[pos_up] != nil
						puts "u"
						if new_s_list[pos_up]["name"] == whitelist || new_s_list[pos_up]["whitelist"] == name
							puts "up"
							to_place << false
							
						end
					end
					if new_s_list[pos_down] != nil
						puts "d"
						if new_s_list[pos_down]["name"] == whitelist || new_s_list[pos_down]["whitelist"] == name
							puts "down"
							to_place << false
							
						end
					end
					if new_s_list[pos_nw] != nil
						puts "nw"
						if new_s_list[pos_nw]["name"] == whitelist || new_s_list[pos_nw]["whitelist"] == name
							puts "nw"
							to_place << false
							
						end
					end
					if new_s_list[pos_ne] != nil
						puts "ne"
						if new_s_list[pos_ne]["name"] == whitelist || new_s_list[pos_ne]["whitelist"] == name
							puts "ne"
							to_place << false
							
						end
					end
					if new_s_list[pos_se] != nil
						puts "se"
						if new_s_list[pos_se]["name"] == whitelist || new_s_list[pos_se]["whitelist"] == name
							puts "se"
							to_place << false
							
						end
					end
					if new_s_list[pos_sw] != nil
						puts "sw"
						if new_s_list[pos_sw]["name"] == whitelist || new_s_list[pos_sw]["whitelist"] == name
							puts "sw"
							to_place << false
							
						end
					end
			
					to_place = not(to_place.include? false)

				end
			elsif x_pos == 0
				puts 'x_pos = 0'
				if y_pos == 0 
					
					
				elsif y_pos == @seats_y

				end
			elsif x_pos = @seats_x
				puts 'what!'
				if y_pos == 0 
				elsif y_pos == @seats_y
				end
			end

			#noise

			#coords delete first item

			print @coord
			puts

			if to_place == true
				puts "Placed"
				new_layout[y_pos][x_pos] = id
				@coord.shift
				new_array_s_list.shift
				@coord = @coord.sort{|a,b|b[1]<=>a[1]}.reverse
			else
				puts "Cannot place here"
				@coord = @coord.rotate
			end
			student_num += 1

			print_layout(new_layout)

			puts new_array_s_list
		
		end
		print_layout(new_layout)
	end

	def manual_list(new_layout,s_list)
		print s_list
		puts
		print_layout(new_layout)
		s_list.each do  |key, value|
			
			puts "Enter Position for Name: #{value["name"]}: Must be Available seat (Black) Example: B5"
			position = gets.strip

			if position.length == 2 
				x_pos = ( position[1].to_i - 1 )
				y_pos = letter_to_num(position[0])
				if new_layout[y_pos][x_pos] == @yes_seat
					new_layout[y_pos][x_pos] = key
					print_layout(new_layout)
				else
					puts "Already taken, or Unavailable Seat."
				end
				
				
			else 
				puts "Must be 2 characters"
			end
		end
		puts "FINAL LAYOUT"
		print_layout(new_layout) 
	end

	def student_list_data
		puts 'Enter Class name'
		classname = gets.strip
		student_list = Hash.new
		id = 1
		loopy = true 


		# warn user if student list > available seats
		while loopy == true
			puts 'Enter Student Name'
			name = gets.strip
			puts "Student male or female m/f"
			gender = gets.strip.upcase
			puts 'Enter noise level of student'
			

			noise = gets.strip
			puts 'Enter name of student/s to not sit next to'
			whitelist = gets.strip
			puts 'Enter priority of learning (if whether needs to be close to front)'
			level_learning = gets.strip
			puts 'Input another student? y/n'
			if gets.strip.upcase! == 'N'
				loopy = false
			else
				puts 'Continuing..'
			end
			student_list.merge!("#{id}"  => {"name" => "#{name}", "gender" => "#{gender}", "level" => "#{level_learning}", "whitelist" => "#{whitelist}", "noise" => "#{noise}"})
			id +=1
		end
		student_list
	end

	private 

		def num_to_letter(x)
			x
		    if x == 0
		        l = "A"
		    elsif x == 1
		        l = "B"
		    elsif x == 2
		        l = "C"
		    elsif x == 3
		        l = "D"
		    elsif x == 4
		        l = "E"
		    elsif x == 5
		        l = "F"
		    elsif x == 6
		        l = "G"
		    elsif x == 7
		        l = "H"
		    elsif x == 8
		        l = "I"
		    elsif x == 9
		        l = "J"
		    end
		    l
		end

		def letter_to_num(x)
		    if x == "A"
		        l = 0
		    elsif x == "B"
		        l = 1
		    elsif x == "C"
		        l = 2
		    elsif x == "D"
		        l = 3
		    elsif x == "E"
		        l = 4
		    elsif x == "F"
		        l = 5
		    elsif x == "G"
		        l = 6
		    elsif x == "H"
		        l = 7
		    elsif x == "I"
		        l = 8
		    elsif x == "J"
		        l = 9
		    end
		    l
		end

		def print_layout(seat_array)
			for row in 0..@seats_y-1
				if row == 0 
					print "|"
					for i in 0..(seat_array[row].length-1)	
						print "  #{i+1}  "
					end
					print "|"
					puts
				end
				row_array = seat_array[row]
				print(num_to_letter(row),row_array,num_to_letter(row))
				puts
			end
			puts 
		end

		def is_number?
		  self.to_f == self
		end
end

seats = Seating.new
# seat_layout = seats.seat_layout(seats.class_layout)
# seat_layout_dup = seat_layout.dup
# s_list_dup = seats.student_list_data.dup


seat_layout = [["○", "○", "○", "○", "○", "○"], ["○", "◉", "◉", "◉", "◉", "○"], ["○", "◉", "○", "○", "◉", "○"], ["○", "◉", "○", "○", "◉", "○"], ["○", "◉", "◉", "◉", "◉", "○"], ["○", "○", "○", "○", "○", "○"]]
s_list = {"1"=>{"name"=>"Matthew", "gender"=>"M", "level"=>"3", "whitelist"=>"Oliver", "noise"=>"3"}, "2"=>{"name"=>"Oliver", "gender"=>"M", "level"=>"2", "whitelist"=>"Ishak", "noise"=>"2"}, "3"=>{"name"=>"Ishak", "gender"=>"M", "level"=>"1", "whitelist"=>"Zak", "noise"=>"3"}, "4"=>{"name"=>"Sultan", "gender"=>"F", "level"=>"3", "whitelist"=>"Zineb", "noise"=>"1"}, "5"=>{"name"=>"Zineb", "gender"=>"F", "level"=>"3", "whitelist"=>"Hindz", "noise"=>"3"}, "6"=>{"name"=>"Jess", "gender"=>"F", "level"=>"3", "whitelist"=>"Kony", "noise"=>"1"}}
seat_layout_dup = seat_layout.dup
s_list_dup = s_list.dup

# seats.algorithm(seat_layout_dup, s_list_dup)

main_loop = true
while main_loop
	puts "Enter Data Manually or Automatic with smart algorithm (m/a)"
	decision = gets.strip.upcase
	if decision== 'M'
		seats.manual_list(seat_layout, s_list)
		main_loop = false
	elsif decision == "A"
		seats.algorithm(seat_layout_dup, s_list_dup)
		main_loop = false
	else
		puts "Did not understand, Do again."
	end
end


seat_layout = [["○", "○", "○", "○", "○", "○"], ["○", "◉", "◉", "◉", "◉", "○"], ["○", "◉", "○", "○", "◉", "○"], ["○", "◉", "○", "○", "◉", "○"], ["○", "◉", "◉", "◉", "◉", "○"], ["○", "○", "○", "○", "○", "○"]]
s_list = {"1"=>{"name"=>"Matthew", "gender"=>"M", "level"=>"3", "whitelist"=>"Oliver", "noise"=>"3"}, "2"=>{"name"=>"Oliver", "gender"=>"M", "level"=>"2", "whitelist"=>"Ishak", "noise"=>"2"}, "3"=>{"name"=>"Ishak", "gender"=>"M", "level"=>"1", "whitelist"=>"Zak", "noise"=>"3"}, "4"=>{"name"=>"Sultan", "gender"=>"F", "level"=>"3", "whitelist"=>"Zineb", "noise"=>"1"}, "5"=>{"name"=>"Zineb", "gender"=>"F", "level"=>"3", "whitelist"=>"Hindz", "noise"=>"3"}, "6"=>{"name"=>"Jess", "gender"=>"F", "level"=>"3", "whitelist"=>"Kony", "noise"=>"1"}}












