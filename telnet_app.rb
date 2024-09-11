require 'socket'

def telnet_connect(host, port)
  begin
    # Устанавливаем TCP-соединение с указанным хостом и портом
    # TCPSocket.new создает новый сокет для TCP-соединения
    # host - адрес удаленного хоста
    # port - номер порта, к которому мы подключаемся
    socket = TCPSocket.new(host, port)
    puts "Connected to #{host} on port #{port}"

    # Ожидаем ввода от пользователя для отправки на сервер
    loop do
      print "Enter command (or 'exit' to quit): "
      input = gets.chomp # Получаем команду от пользователя
      break if input.downcase == 'exit' 

  
      socket.puts(input)

      # Получаем и выводим ответ от сервера
      response = socket.gets 
      puts "Response: #{response}" if response 
    end
  rescue StandardError => e
    puts "Failed to connect to #{host} on port #{port}: #{e.message}"
  ensure
    # Закрываем сокет после использования
    socket.close if socket
  end
end

puts "Enter the host to connect via Telnet:"
host = gets.chomp # Ввод хоста для подключения
puts "Enter the port to connect to:"
port = gets.chomp.to_i # Ввод порта для подключения
telnet_connect(host, port) # Вызываем метод для подключения к указанному хосту и порту
