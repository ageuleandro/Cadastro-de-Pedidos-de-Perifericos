#!/usr/bin/env ruby
require_relative '../lib/cadastro'

puts "Bem-vindo ao sistema de cadastro de pedidos de periféricos!"
puts "-------------------------------------------------------------------"
# Criando objetos das outras classes
usuario = Usuario.new(1, "Ageu", "leandro.junior7@gmail.com")
puts "Usuário criado: Nome: #{usuario.nome}, Email: #{usuario.email}"
puts "-------------------------------------------------------------------"
periferico = Periferico.new(1, "Notebook", "Dell i7 16GB RAM SSD 240", 2)
puts "Periferico criado: Nome: #{periferico.nome}, Descrição: #{periferico.descricao}, Estoque: #{periferico.quantidade_disponivel}"
puts "-------------------------------------------------------------------"


# Testando a Classe Pedido
pedido = Pedido.new(1, usuario, periferico, 5)
puts "Pedido criado: Usuário: #{pedido.usuario.nome}, Periférico: #{pedido.periferico.nome}, Quantidade: #{pedido.quantidade}, Status: #{pedido.status}"
puts "-------------------------------------------------------------------"

# Reduzindo o estoque
if periferico.reduzir_estoque(3)
  puts "Estoque atualizado: #{periferico.quantidade_disponivel} unidades restantes"
else
  puts "Estoque insuficiente para reduzir"
end
puts "-------------------------------------------------------------------"


# Aprovando o Pedido
pedido.aprovar
puts "Status do pedido após análise: #{pedido.status}"


