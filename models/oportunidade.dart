class Oportunidade {
  Oportunidade(
    this.titulo,
    this.cliente,
    this.valor,
    this.descricao, {
    this.categoria = 'Tecnologia',
  });
  String titulo, cliente, valor, descricao, categoria;
}

