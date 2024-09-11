equire 'socket'

def ping(host)
 
  socket = Socket.new(Socket::AF_INET, Socket::SOCK_RAW, Socket::IPPROTO_ICMP)

  
  packet = [8, 0, Process.pid & 0xFFFF, 0, 64].pack('C*')

  start_time = Time.now

  # Отправляем ICMP-запрос
 
  socket.send(packet, 0, Socket.sockaddr_in(0, host))

  
  begin
    response = socket.recvfrom(1024) 
    end_time = Time.now
    elapsed_time = (end_time - start_time) * 1000 
    puts "Ping to #{host}: #{elapsed_time.round(2)} ms"
  rescue
    puts "Request timed out."
  ensure
    socket.close
  end
end

# Пример использования
puts "Enter the host to ping:"
host = gets.chomp 
ping(host)
