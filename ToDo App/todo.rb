# identify THE BASIC diference of 2 METHOD: "print" & "puts"
# BE CAREFUL to define a fuction without return value
# require 'rubygems'
require "colorize"
class Item
    def initialize(name, done = false)
        @name=name
        @done=done
    end

    def name
        @name
    end

    def done?
        @done
    end

    def display
        if @done == true
            " [x] #{@name}".colorize(:blue)
        else 
            " [ ] #{@name}".colorize(:yellow)
        end
    end
    
    def mark_done(flag)
        if flag
            @done=true
        else
            @done=false
        end
    end

    def self.new_from_line(line)
        name =  line[6..-1]
        done = line[3] == "x"
        Item.new(name, done)
    end

end

class List
    def initialize(name, items = [])
        @name=name
        @items=items
    end

    def items
        @items
    end

    def add(*item)
            item.each do |x|
                if x != "" and x!= nil
                    if x[2] == "[" and x[4] =="]"
                        @items.push(Item.new_from_line(x))
                    else
                        @items.push(Item.new(x)) 
                    end
                end
            end
        
    end
    
    def display(index)
        puts "#{index+1}"+"."+"#{@items[index].display}"
    end

    def display_all
        if @items.length == 0 
            puts "No activity in todolist"
        else 
            @items.each_with_index do |value,index|
                display(index)
            end
        end
    end

    def display_done
        checkCount= 0
        if @items.length == 0
            puts "No activity done in todolist"
        else 
            @items.each_with_index do |value,index|
                if value.done? 
                    display(index)
                    checkCount += 1
                end
            end
            if checkCount == 0 
                puts "No activity done in todolist"
            end
        end
    end

    def display_undone
        checkCount= 0
        if @items.length == 0
            puts "All activities done in todolist"
        else 
            @items.each_with_index do |value,index|
                if !value.done? 
                    display(index)
                    checkCount += 1
                end
            end
            if checkCount == 0 
                puts "All activities done in todolist"
            end
        end
    end

    
    # def removeActWihName(*act)
    #     act.each do |x|
    #         @items.each do |z|
    #             if x == z.name
    #                 @items.delete(z)
                    
    #             end
    #         end
    #     end
    
    # end

    def removeActWithIndex(*list)
        # list.reject! do |x|
        #     x <= 0
        # end
        
        #identify index-real because after delete, index of elements are updated
        # listSort= (list.sort).uniq # sort listIndex and remove multiple elements same value, keep one
        # newList = []
        # subToReal = 0
        # listSort.map do |x|
        #     x = x - subToReal
        #     subToReal = subToReal +1
        #     newList +=[x]
        # end
        # #remove item by using newList with index-real
        # newList.each do |x|
        #     @items.delete_at(x-1)
        # end


        listSort= (list.sort).uniq #sort listIndex and remove multiple elements same value, keep one
        subToReal = 0
        listSort.map do |x|
            @items.delete_at(x-1-subToReal)#remove item by using newList with index-1-subToReal
            subToReal = subToReal +1
        end
       

    end

    def mark_act(*list,flag)
        list= list.uniq
        list.map do |x|
            @items[x-1].mark_done(flag)
        end
    end

 
end

class Todo
    def initialize(filename = "todo.md")
        @filename = filename # we save the name so we can load it later
        @list = List.new("Today") # we only keep 1 list for the app
    end
    
    def load_data
        data = File.read(@filename)
        data.each_line do |line|
            line.delete!("\n")
            @list.add(line)
        end
    end

    

    def show_undone
        @list.display_undone
    end

    def show_done
        @list.display_done
    end
    
    def show_all
        @list.display_all

    end

    def add(*item)
        @list.add(*item)
    end

    def removeAct(*listIndex)
        @list.removeActWithIndex(*listIndex)
    end

    def mark(*listAct,flag)
        @list.mark_act(*listAct,flag)
    end

    def list
        @list
    end

end

listActs=Todo.new("todolist.md")
listActs.load_data

puts "Wel come to the Ruby TodoList App".colorize(:green)
puts "-h".colorize(:red) + " or " +"help".colorize(:red) +" to view the help menu"
puts  ""
puts  ""
puts "Todo List ".colorize(:green)
puts "-------------------------------------------------------------------------------------".colorize(:green)
listActs.show_all
puts  ""
puts "-------------------------------------------------------------------------------------".colorize(:green)
inAct=""
while inAct != "exit"

    print "Please enter an option: ".colorize(:green)
    inAct=gets.chomp

    case inAct

    when "-h" || "-help"
        puts "-h".colorize(:red) + " or " + "-help".colorize(:red) + ": Display a list of all conmand available"
        puts "-d".colorize(:red) + " or " + "display".colorize(:red) + ": Display your todo list with all items"
        puts "-dd".colorize(:red) + " or " + "display done".colorize(:red) + ": Display your todo list with all items"
        puts "-dud".colorize(:red) +" or " +"display undone".colorize(:red) +": Display your todo list with all items"
        puts "-a".colorize(:red) +" or " +"add".colorize(:red) +": Allows you to add new items to your todo list" 
        puts "-r".colorize(:red) +" or " +"remove".colorize(:red) +": Allows you to remove items from your todo list"
        puts "-m".colorize(:red) +" or " +"mark".colorize(:red) +": Allows you to check items on the list as complete"
        puts "-um".colorize(:red) +" or " +"unmark".colorize(:red) +": Allows you to uncheck items on the list as complete on your todo list"
        puts "-e".colorize(:red) +" or " +"exit".colorize(:red) +": Exits App"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)

    when "-d" || "display"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "-dd" || "display done "
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_done
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "-dud" || "display undone"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_undone
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green) 
    when "-a" || "add"
        print "Which items you want to add? (use ',' between them if you want to add more one): ".colorize(:green)
        inActAdd = (gets.chomp).split(",")
        listActs.add(*inActAdd)
        puts "Items"+"#{inActAdd}"+"added in your list"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "-r" || "remove"
        print "Which items you want to remove? (use ',' between them if you want to remove more one): ".colorize(:green)
        inActRem = (gets.chomp).split(",").map {|x| x.to_i}
        inActRem.reject! do |x|
            x <= 0
        end
        listActs.removeAct(*inActRem)
        puts "Items "+"#{inActRem}"+" removed from your list"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "-m" || "mark"
        print "Which items you want to check? (use ',' between them if you want to mark more one): ".colorize(:green)
        intActMa = (gets.chomp).split(",").map {|x| x.to_i}
        intActMa.reject! do |x|
            x <= 0
        end
        listActs.mark(*intActMa,true)
        puts "Items "+"#{intActMa}"+" check in your list"
        puts  ""
        puts  ""
        puts "Todo List".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "-um" || "unmark"
        print "Which items you want to mark? (use ',' between them if you want to mark more one): ".colorize(:green)
        intActUma = (gets.chomp).split(",").map {|x| x.to_i}
        intActUma.reject! do |x|
            x <= 0
        end
        listActs.mark(*intActUma,false)
        puts "Items "+"#{intActUma}"+" unchecked in your list"
        puts  ""
        puts  ""
        puts "Todo List ".colorize(:green)
        puts "-------------------------------------------------------------------------------------".colorize(:green)
        puts  ""
        listActs.show_all
        puts  ""
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    when "e" || "exit"
        puts "Thank you!".colorize(:green)
        break
    else
        puts "Sorry!".colorize(:red) + " I don't understand that command"
        puts "-h".colorize(:red) + " or " + " help".colorize(:red) + " to view the help menu"
        puts "-------------------------------------------------------------------------------------".colorize(:green)
    end

end







    



