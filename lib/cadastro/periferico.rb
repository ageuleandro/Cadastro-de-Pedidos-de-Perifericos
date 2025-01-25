class Periferico

  attr_accessor :id, :nome, :descricao, :quantidade_disponivel

  def initialize(id, nome, descricao, quantidade_disponivel)
    @id = id
    @nome = nome
    @descricao = descricao
    @quantidade_disponivel = quantidade_disponivel
  end

  def reduzir_estoque(quantidade)
    if quantidade <= @quantidade_disponivel
      @quantidade_disponivel -= quantidade
      true
    else
      false
    end
  end









end
