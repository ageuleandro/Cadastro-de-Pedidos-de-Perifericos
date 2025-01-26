class Pedido
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
      @status = "Aprovado"
      puts "Pedido #{id} Aprovado com Sucesso"
    else
      @status = "Rejeitado"
      puts "Pedido #{id} Rejeitado: Estoque insuficiente"
    end
  end
end
