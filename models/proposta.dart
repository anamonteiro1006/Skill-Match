class Proposta {
  Proposta(
    this.oportunidade,
    this.profissional,
    this.valor,
    this.prazo,
    this.mensagem, {
    this.status = 'Em análise',
  });
  String oportunidade, profissional, valor, prazo, mensagem, status;
}

