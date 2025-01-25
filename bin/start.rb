#!/usr/bin/env ruby
require_relative '../lib/cadastro'

puts "Bem-vindo ao sistema de cadastro de pedidos de periféricos!"
usuario = Usuario.new(1, "João", "joao@example.com")
puts "Usuário criado: Nome: #{usuario.nome}, Email: #{usuario.email}"

periferico = Periferico.new(1, "Monitor LG", "Monitor de Coputador", 100)
puts "Periferico criado: Nome: #{periferico.nome}, Estoque: #{periferico.quantidade_disponivel}"

# Reduzindo o estoque
if periferico.reduzir_estoque(3)
  puts "Estoque atualizado: #{periferico.quantidade_disponivel} unidades restantes"
else
  puts "Estoque insuficiente para reduzir"
end

# Testando a Classe Pedido
pedido = Pedido.new(1, usuario, periferico, 5, "pendente")
puts "Pedido criado: Usuário: #{pedido.usuario.nome}, Periférico: #{pedido.periferico.nome}, Quantidade: #{pedido.quantidade}, Status: #{pedido.status}"
# Aprovando o Pedido
pedido.aprovar
puts "Status do pedido após aprovação: #{pedido.status}"


