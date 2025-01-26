class Usuario
  attr_accessor :id, :nome, :email

  def initialize(id, nome, email)
    @id = id
    @nome = nome
    @email = email
  end
end