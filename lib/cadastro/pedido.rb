class Pedido
  # id: Integer
  # usuario: Objeto da classe Usuario
  # periferico: Objeto da classe Periferico
  # quantidade: Integer

  attr_accessor :id, :usuario, :periferico, :quantidade, :status

  def initialize(id, usuario, periferico, quantidade)
    @id = id
    @usuario = usuario
    @periferico = periferico
    @quantidade = quantidade
    @status = "Pendente"
  end

  def aprovar
    if @periferico.reduzir_estoque(@quantidade)
      puts "Pedido #{@id}: Quantidade disponível. Aprovar ou Reprovar? (Digite 'Aprovar' ou 'Reprovar')"
      decisao = gets.chomp

      if decisao == "Aprovar"
        @status = "Aprovado"
        puts "Pedido #{@id} Aprovado com Sucesso."
      elsif decisao == "Reprovar"
        @status = "Reprovado"
        puts "Pedido #{@id} foi Reprovado."
      else
        puts "Opção inválida. O pedido #{@id} permanecerá pendente."
      end
    else
      @status = "Reprovado"
      puts "Pedido #{@id}: Quantidade insuficiente no estoque. Pedido Reprovado."
    end
  end
end
