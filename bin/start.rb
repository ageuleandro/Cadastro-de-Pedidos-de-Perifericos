#!/usr/bin/env ruby
require_relative '../lib/cadastro'
require 'json'

class Sistema
  def initialize
    @usuarios = []
    @perifericos = []
    @pedidos = []
    carregar_usuarios
    carregar_perifericos
    carregar_pedidos
  end

  def adicionar_usuario
    print "ID do usuário: "
    id = gets.chomp.to_i
    print "Nome do usuário: "
    nome = gets.chomp
    print "Email do usuário: "
    email = gets.chomp
    @usuarios << Usuario.new(id, nome, email)
    salvar_usuarios #metodo JSON
    puts "Usuário '#{nome}' adicionado com sucesso!"
  end

  def adicionar_periferico
    print "ID do periférico: "
    id = gets.chomp.to_i
    print "Nome do periférico: "
    nome = gets.chomp
    print "Descrição do periférico: "
    descricao = gets.chomp
    print "Quantidade disponível: "
    quantidade = gets.chomp.to_i
    @perifericos << Periferico.new(id, nome, descricao, quantidade)
    salvar_perifericos #metodo JSON
    puts "Periférico '#{nome}' adicionado com sucesso!"
  end

  def criar_pedido
    puts "Usuários disponíveis:"
    @usuarios.each { |u| puts "ID: #{u.id}, Nome: #{u.nome}" }
    print "ID do usuário que está fazendo o pedido: "
    user_id = gets.chomp.to_i
    usuario = @usuarios.find { |u| u.id == user_id }

    puts "Periféricos disponíveis:"
    @perifericos.each { |p| puts "ID: #{p.id}, Nome: #{p.nome}, Estoque: #{p.quantidade_disponivel}" }
    print "ID do periférico desejado: "
    perif_id = gets.chomp.to_i
    periferico = @perifericos.find { |p| p.id == perif_id }

    if usuario.nil? || periferico.nil?
      puts "Usuário ou periférico inválido. Tente novamente."
      return
    end

    print "Quantidade desejada: "
    quantidade = gets.chomp.to_i

    @pedidos << Pedido.new(@pedidos.size + 1, usuario, periferico, quantidade)
    salvar_pedidos #metodo JSON
    puts "Pedido criado com sucesso!"
  end


  def listar_pedidos
    if @pedidos.empty?
      puts "Nenhum pedido encontrado."
    else
      @pedidos.each do |p|
        puts "Pedido ##{p.id}: Usuário: #{p.usuario.nome}, Periférico: #{p.periferico.nome}, Quantidade: #{p.quantidade}, Status: #{p.status}"
      end
    end
  end

  def aprovar_pedido
    listar_pedidos
    print "Digite o ID do pedido para aprovar/rejeitar: "
    pedido_id = gets.chomp.to_i
    pedido = @pedidos.find { |p| p.id == pedido_id }

    if pedido.nil?
      puts "Pedido não encontrado. Tente novamente."
      return
    end

    pedido.aprovar
  end

  def exibir_menu
    puts "\n========= MENU ========="
    puts "1. Adicionar Usuário"
    puts "2. Adicionar Periférico"
    puts "3. Criar Pedido"
    puts "4. Listar Pedidos"
    puts "5. Aprovar/Rejeitar Pedido"
    puts "6. Sair"
    print "Escolha uma opção: "
  end

  def executar
    loop do
      exibir_menu
      opcao = gets.chomp.to_i
      case opcao
      when 1
        adicionar_usuario
      when 2
        adicionar_periferico
      when 3
        criar_pedido
      when 4
        listar_pedidos
      when 5
        aprovar_pedido
      when 6
        puts "Saindo do sistema. Até logo!"
        break
      else
        puts "Opção inválida. Tente novamente."
      end
    end
  end

  def salvar_usuarios
    File.open("usuarios.json", "w") do |file|
      file.write(JSON.pretty_generate(@usuarios.map { |u| { id: u.id, nome: u.nome, email: u.email } }))
    end
  end

  def carregar_usuarios
    if File.exist?("usuarios.json")
      @usuarios = JSON.parse(File.read("usuarios.json")).map do |dados|
        Usuario.new(dados["id"], dados["nome"], dados["email"])
      end
    else
      @usuarios = []
    end
  end

  def salvar_perifericos
    File.open("perifericos.json", "w") do |file|
      file.write(JSON.pretty_generate(@perifericos.map { |p| { id: p.id, nome: p.nome, descricao: p.descricao, quantidade_disponivel: p.quantidade_disponivel } }))
    end
  end

  def carregar_perifericos
    if File.exist?("perifericos.json")
      @perifericos = JSON.parse(File.read("perifericos.json")).map do |dados|
        Periferico.new(dados["id"], dados["nome"], dados["descricao"], dados["quantidade_disponivel"])
      end
    else
      @perifericos = []
    end
  end

  def salvar_pedidos
    File.open("pedidos.json", "w") do |file|
      file.write(JSON.pretty_generate(@pedidos.map do |p|
        {
          id: p.id,
          usuario_id: p.usuario.id,
          periferico_id: p.periferico.id,
          quantidade: p.quantidade,
          status: p.status
        }
      end))
    end
  end

  def carregar_pedidos
    if File.exist?("pedidos.json")
      @pedidos = JSON.parse(File.read("pedidos.json")).map do |dados|
        usuario = @usuarios.find { |u| u.id == dados["usuario_id"] }
        periferico = @perifericos.find { |p| p.id == dados["periferico_id"] }
        Pedido.new(dados["id"], usuario, periferico, dados["quantidade"]).tap do |pedido|
          pedido.status = dados["status"]
        end
      end
    else
      @pedidos = []
    end
  end



end

Sistema.new.executar







