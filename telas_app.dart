part of '../main.dart';

// Fluxos e telas do aplicativo, preservados da versão anterior.
extension TelasApp on AplicativoState {
  Widget construirTela(BuildContext context) {
    switch (tela) {
      case 'boas_vindas':
        return Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/img/logo.png', width: 240),
                    const SizedBox(height: 24),
                    titulo('Conectando talento a novas oportunidades!'),
                    botao('Entrar', () => ir('login')),
                    botao(
                      'Criar uma conta',
                      () => ir('cadastro'),
                      contorno: true,
                    ),
            
                  ],
                ),
              ),
            ),
          ),
        );
      case 'login':
        return acesso('login');
      case 'recuperar_senha':
        return formulario('Recuperar senha', ['E-mail'], (v) {
          ir('login');
          aviso(
            'Recuperação demonstrativa: não há envio de e-mail neste protótipo.',
          );
        });
      case 'cadastro':
        return acesso('cadastro');
      case 'tipo_conta':
        return pagina('Como deseja utilizar o SkillMatch?', [
          bloco(
            'Freelancer',
            'Oferecer meus serviços, aprender e encontrar oportunidades.',
            () {
              tipo = 'Freelancer';
              _salvarPerfil();
              ir('completar_perfil');
            },
            icone: Icons.person,
          ),
          bloco('Cliente', 'Encontrar profissionais e contratar serviços.', () {
            tipo = 'Cliente';
            _salvarPerfil();
            ir('completar_perfil');
          }, icone: Icons.business_center),
        ], menu: false);
      case 'completar_perfil':
        return formulario(
          'Complete seu perfil — $tipo',
          tipo == 'Cliente'
              ? [
                  'Nome da empresa ou cliente',
                  'Área de atuação',
                  'Descrição',
                  'Localização',
                ]
              : [
                  'Nome completo',
                  'Área profissional',
                  'Habilidades',
                  'Breve descrição',
                  'Experiência',
                ],
          (v) {
            atualizarEstado(() {
              if (tipo == 'Cliente') {
                empresa = v[0];
                area = v[1];
                descricao = v[2];
              } else {
                nome = v[0];
                area = v[1];
                habilidades = v[2];
                descricao = v[3];
              }
              tela = 'inicio';
            });
            _salvarPerfil();
            aviso('Perfil cadastrado!');
          },
        );
      case 'inicio':
        return pagina(
          'Página inicial ${tipo == 'Cliente' ? 'Cliente' : 'Freelancer'}',
          tipo == 'Cliente'
              ? [
                  titulo('Olá, $empresa!'),
                  const Text('Confira suas oportunidades e propostas'),
                  bloco(
                    'Minhas oportunidades',
                    '${oportunidades.where((o) => o.cliente == empresa).length} oportunidades publicadas',
                    () => ir('minhas_oportunidades'),
                  ),
                  bloco(
                    'Propostas recebidas',
                    '${propostas.where((p) => oportunidades.any((o) => o.titulo == p.oportunidade && o.cliente == empresa)).length} propostas',
                    () => ir('propostas_recebidas'),
                  ),
                  botao(
                    'Publicar nova oportunidade',
                    () => ir('publicar_oportunidade'),
                  ),
                  titulo('Oportunidades em destaque'),
                  ...oportunidades
                      .take(2)
                      .map(
                        (o) => bloco(
                          o.titulo,
                          'R\$ ${o.valor} • ${o.cliente}',
                          () => abrirOportunidade(o),
                        ),
                      ),
                ]
              : [
                  titulo('Olá, $nome!'),
                  bloco(
                    'Seu perfil está 80% completo',
                    'Complete seu perfil para se destacar',
                    () => ir('editar_perfil'),
                    icone: Icons.person,
                  ),
                  titulo('Suas habilidades'),
                  Text(habilidades),
                  titulo('Oportunidades para você'),
                  ...oportunidades
                      .take(3)
                      .map(
                        (o) => bloco(
                          o.titulo,
                          '${o.cliente} • R\$ ${o.valor}',
                          () => abrirOportunidade(o),
                        ),
                      ),
                  botao('Ver minhas propostas', () => ir('minhas_propostas')),
                  botao(
                    'Desafios práticos',
                    () => ir('desafios'),
                    contorno: true,
                  ),
                ],
          voltarTopo: false,
        );
      case 'buscar':
        return pagina(
          tipo == 'Cliente' ? 'Buscar profissionais' : 'Buscar oportunidades',
          [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'O que está procurando?',
              ),
              onChanged: (v) => atualizarEstado(() => busca = v),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 7,
              runSpacing: 8,
              children: ['Todas', 'Tecnologia', 'Design', 'Marketing']
                  .map(
                    (c) => ChoiceChip(
                      label: Text(c),
                      selected: categoria == c,
                      onSelected: (_) => atualizarEstado(() => categoria = c),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            if (tipo == 'Cliente')
              ...['Maria da Silva', 'Joana Siqueira', 'Matheus Fonseca']
                  .where((p) => p.toLowerCase().contains(busca.toLowerCase()))
                  .map(
                    (p) => bloco(p, 'Desenvolvimento Web • Avaliação 4,5', () {
                      ir('perfil_publico');
                    }, icone: Icons.person),
                  )
            else
              ...oportunidades
                  .where(
                    (o) =>
                        (categoria == 'Todas' || o.categoria == categoria) &&
                        ('${o.titulo} ${o.cliente}'.toLowerCase().contains(
                          busca.toLowerCase(),
                        )),
                  )
                  .map(
                    (o) => bloco(
                      o.titulo,
                      '${o.cliente} • R\$ ${o.valor}',
                      () => abrirOportunidade(o),
                    ),
                  ),
          ],
          voltarTopo: false,
        );
      case 'detalhes_oportunidade':
        final o = selecionada ?? oportunidades.first;
        return pagina('Detalhes da oportunidade', [
          titulo(o.titulo),
          Text(o.descricao),
          titulo('Requisitos'),
          const Text('HTML • CSS • Responsabilidade'),
          titulo('Valor'),
          Text('R\$ ${o.valor}'),
          const Text('Prazo: 15 dias'),
          titulo('Sobre o cliente'),
          Text(o.cliente),
          if (tipo == 'Cliente' && o.cliente == empresa)
            botao('Excluir oportunidade', () => confirmarExclusao(o), contorno: true)
          else
            botao('Enviar proposta', () => ir('enviar_proposta')),
        ]);
      case 'enviar_proposta':
        return formulario(
          'Enviar proposta',
          [
            'Valor da proposta (R\$)',
            'Prazo de entrega (dias)',
            'Mensagem para o cliente',
          ],
          (v) {
            atualizarEstado(() {
              propostas.add(
                Proposta(
                  selecionada?.titulo ?? oportunidades.first.titulo,
                  nome,
                  v[0],
                  v[1],
                  v[2],
                ),
              );
              tela = 'minhas_propostas';
            });
            _salvarDados();
            aviso('Proposta enviada com sucesso!');
          },
          descricaoTopo: 'Projeto: ${selecionada?.titulo ?? ''}',
        );
      case 'minhas_propostas':
        return pagina('Minhas propostas', [
          if (propostas.where((p) => p.profissional == nome).isEmpty)
            const Text('Você ainda não enviou propostas.'),
          ...propostas
              .where((p) => p.profissional == nome)
              .map(
                (p) => bloco(
                  p.oportunidade,
                  'R\$ ${p.valor} • ${p.status}',
                  () => abrirProposta(p),
                ),
              ),
        ]);
      case 'propostas_recebidas':
        return pagina('Propostas recebidas', [
          ...propostas.where((p) => oportunidades.any((o) => o.titulo == p.oportunidade && o.cliente == empresa)).map(
            (p) => bloco(
              p.profissional,
              '${p.oportunidade} • R\$ ${p.valor} • ${p.status}',
              () => abrirProposta(p),
              icone: Icons.person,
            ),
          ),
        ]);
      case 'detalhes_proposta':
        final p = propostaSelecionada ?? propostas.first;
        return pagina('Detalhes da proposta', [
          titulo(p.oportunidade),
          Text('Profissional: ${p.profissional}'),
          Text('Valor: R\$ ${p.valor}'),
          Text('Prazo: ${p.prazo} dias'),
          Text('Mensagem: ${p.mensagem}'),
          Text('Status: ${p.status}'),
          if (tipo == 'Cliente')
            botao('Aceitar e contratar', () {
              atualizarEstado(() => p.status = 'Aceita');
              _salvarDados();
              aviso('Proposta aceita!');
              ir('propostas_recebidas');
            })
          else
            botao('Voltar às minhas propostas', () => ir('minhas_propostas')),
        ]);
      case 'publicar_oportunidade':
        return formulario(
          'Publique uma oportunidade',
          [
            'Título do projeto',
            'Descrição',
            'Categoria',
            'Orçamento (R\$)',
            'Prazo (dias)',
            'Localização',
          ],
          (v) {
            atualizarEstado(() {
              oportunidades.insert(
                0,
                Oportunidade(v[0], empresa, v[3], v[1], categoria: v[2]),
              );
              tela = 'minhas_oportunidades';
            });
            _salvarDados();
            aviso('Oportunidade publicada!');
          },
        );
      case 'minhas_oportunidades':
        return pagina('Minhas oportunidades', [
          if (!oportunidades.any((o) => o.cliente == empresa))
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text('Você ainda não publicou oportunidades.'),
            ),
          ...oportunidades.where((o) => o.cliente == empresa).map(
            (o) => Row(
              children: [
                Expanded(
                  child: bloco(
                    o.titulo,
                    'Ativa • R\$ ${o.valor}',
                    () => abrirOportunidade(o),
                  ),
                ),
                IconButton(
                  tooltip: 'Excluir oportunidade',
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => confirmarExclusao(o),
                ),
              ],
            ),
          ),
          botao(
            'Publicar nova oportunidade',
            () => ir('publicar_oportunidade'),
          ),
          botao(
            'Ver propostas recebidas',
            () => ir('propostas_recebidas'),
            contorno: true,
          ),
        ]);
      case 'perfil':
        return pagina('Meu perfil', [
          const CircleAvatar(
            radius: 37,
            backgroundColor: Color(0xFFE7E2FF),
            child: Icon(Icons.person, size: 42, color: roxo),
          ),
          titulo(tipo == 'Cliente' ? empresa : nome),
          Text(area),
          Text(descricao),
          botao('Editar perfil', () => ir('editar_perfil')),
          if (tipo == 'Freelancer') ...[
            titulo('Habilidades'),
            Text(habilidades),
            botao('Portfólio', () => ir('portfolio')),
            botao(
              'Certificados e selos',
              () => ir('certificados'),
              contorno: true,
            ),
            botao(
              'Histórico e avaliações',
              () => ir('historico'),
              contorno: true,
            ),
          ] else ...[
            botao('Minhas oportunidades', () => ir('minhas_oportunidades')),
            botao('Propostas recebidas', () => ir('propostas_recebidas')),
          ],
        ], voltarTopo: false);
      case 'editar_perfil':
        return formulario(
          'Editar perfil',
          tipo == 'Cliente'
              ? ['Nome da empresa ou cliente', 'Área de atuação', 'Localização', 'Descrição']
              : ['Nome', 'Área profissional', 'Habilidades', 'Breve descrição'],
          (v) {
            atualizarEstado(() {
              if (tipo == 'Cliente') {
                empresa = v[0];
              } else {
                nome = v[0];
              }
              area = v[1];
              if (tipo == 'Freelancer') habilidades = v[2];
              descricao = v[3];
              tela = 'perfil';
            });
            _salvarPerfil();
            aviso('Perfil atualizado!');
          },
          iniciais: [
            tipo == 'Cliente' ? empresa : nome,
            area,
            tipo == 'Cliente' ? '' : habilidades,
            descricao,
          ],
        );
      case 'perfil_publico':
        return pagina('Perfil público do freelancer', [
          const CircleAvatar(radius: 35, child: Icon(Icons.person)),
          titulo(nome),
          Text(area),
          const Text('⭐ 4,5 • 12 avaliações'),
          Text(habilidades),
          titulo('Portfólio'),
          ...projetos.map(
            (p) => bloco(p, 'Projeto realizado', () => ir('portfolio')),
          ),
          botao('Contratar', () => ir('minhas_oportunidades')),
        ]);
      case 'cursos':
        return pagina('Aprenda novas habilidades', [
          titulo('Cursos disponíveis'),
          ...List.generate(
            cursos.length,
            (i) => bloco(
              cursos[i],
              '${i == 0 ? 5 : 10} aulas • Certificado disponível',
              () {
                cursoAtual = i;
                ir('detalhes_curso');
              },
              icone: Icons.menu_book,
            ),
          ),
          botao('Desafios práticos', () => ir('desafios'), contorno: true),
        ], voltarTopo: false);
      case 'detalhes_curso':
        return pagina('Detalhes do curso', [
          titulo(cursos[cursoAtual]),
          const Text('Aprenda os fundamentos com aulas práticas e atividades.'),
          const LinearProgressIndicator(value: 0.6, color: roxo),
          titulo('Módulos'),
          ...aulas.map(
            (a) => bloco(a, 'Aula disponível', () {
              aulaAtual = aulas.indexOf(a);
              ir('aula');
            }, icone: Icons.play_circle_outline),
          ),
          botao(matriculado ? 'Continuar aula' : 'Começar curso', () {
            matriculado = true;
            ir('aula');
          }),
        ]);
      case 'aula':
        return pagina('Aula do curso', [
          titulo(aulas[aulaAtual]),
          Container(
            height: 160,
            color: const Color(0xFF1B1B30),
            child: const Center(
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 65,
              ),
            ),
          ),
          const Text(
            'Conteúdo introdutório da aula. Material demonstrativo do protótipo.',
          ),
          botao('Próxima aula', () {
            atualizarEstado(() => aulaAtual = (aulaAtual + 1) % aulas.length);
          }),
          botao('Ver desafios', () => ir('desafios'), contorno: true),
        ]);
      case 'desafios':
        return pagina('Desafios práticos', [
          bloco(
            'Desafio – Landing Page',
            'Crie uma landing page para uma pequena empresa • Prazo: 7 dias',
            () => ir('detalhes_desafio'),
            icone: Icons.code,
          ),
          titulo('Coloque suas habilidades em prática'),
          const Text(
            'Desenvolva uma landing page moderna, criativa e responsiva.',
          ),
          botao('Ver detalhes', () => ir('detalhes_desafio')),
        ]);
      case 'detalhes_desafio':
        return pagina('Detalhes do desafio', [
          titulo('Desafio – Landing Page'),
          const Text(
            'Crie uma landing page responsiva para um produto fictício.',
          ),
          titulo('Requisitos'),
          const Text(
            '• Design moderno\n• Seção de benefícios\n• Formulário de contato\n• Código limpo',
          ),
          const Text('Prazo: 7 dias'),
          botao(
            desafioEnviado ? 'Solução enviada' : 'Enviar solução',
            () => ir('enviar_solucao'),
          ),
        ]);
      case 'enviar_solucao':
        return formulario(
          'Enviar solução',
          ['Título do projeto', 'Link do projeto', 'Descrição'],
          (v) {
            atualizarEstado(() {
              desafioEnviado = true;
              projetos.add(v[0]);
              tela = 'desafios';
            });
            aviso('Solução enviada!');
          },
        );
      case 'portfolio':
        return pagina('Portfólio', [
          botao('+ Adicionar projeto', () => ir('adicionar_projeto')),
          ...projetos.map(
            (p) => bloco(
              p,
              'Projeto de desenvolvimento',
              () => aviso('Projeto: $p'),
              icone: Icons.web,
            ),
          ),
          botao('Editar projetos', () => ir('editar_projetos'), contorno: true),
        ]);
      case 'adicionar_projeto':
        return formulario(
          'Adicionar projeto',
          ['Título', 'Descrição', 'Link do projeto'],
          (v) {
            atualizarEstado(() {
              projetos.add(v[0]);
              tela = 'portfolio';
            });
            aviso('Projeto adicionado!');
          },
        );
      case 'editar_projetos':
        return pagina('Editar projetos', [
          ...projetos.map(
            (p) => Card(
              child: ListTile(
                title: Text(p),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    atualizarEstado(() => projetos.remove(p));
                    aviso('Projeto excluído.');
                  },
                ),
              ),
            ),
          ),
          botao('Voltar ao portfólio', () => ir('portfolio')),
        ]);
      case 'certificados':
        return pagina('Suas conquistas', [
          titulo('Certificados'),
          bloco(
            'CSS Básico',
            'Concluído: 10/06/2026',
            () => aviso('Certificado demonstrativo'),
          ),
          bloco(
            'HTML5 Básico',
            'Concluído: 08/03/2026',
            () => aviso('Certificado demonstrativo'),
          ),
          titulo('Selos de habilidades'),
          const Text('CSS • HTML5 • JavaScript • Comunidade'),
        ]);
      case 'historico':
        return pagina('Histórico e avaliações', [
          titulo('12 serviços realizados • 27 avaliações'),
          bloco(
            'iFood Administrativo',
            '⭐⭐⭐⭐⭐ • Excelente trabalho!',
            () => ir('avaliacao'),
          ),
          bloco(
            'Bradesco',
            '⭐⭐⭐⭐⭐ • Trabalho muito interessante!',
            () => ir('avaliacao'),
          ),
          botao('Avaliar experiência', () => ir('avaliacao')),
        ]);
      case 'avaliacao':
        return formulario(
          'Como foi a sua experiência?',
          ['Nota (1 a 5)', 'Comentário'],
          (v) {
            final nota = int.tryParse(v[0]);
            if (nota == null || nota < 1 || nota > 5) {
              aviso('Informe uma nota entre 1 e 5.');
              return;
            }
            ir('historico');
            aviso('Avaliação enviada!');
          },
        );
      case 'notificacoes':
        return pagina('Notificações', [
          ...notificacoes.map(
            (n) => bloco(n, 'Notificação recente', () {
              if (n.contains('curso')) {
                ir('cursos');
              } else if (n.contains('proposta')) {
                ir(
                  tipo == 'Cliente'
                      ? 'propostas_recebidas'
                      : 'minhas_propostas',
                );
              } else if (n.contains('Desafio')) {
                ir('desafios');
              } else if (n.contains('Avaliação')) {
                ir('historico');
              } else {
                ir('buscar');
              }
            }, icone: Icons.notifications_active_outlined),
          ),
        ]);
      case 'configuracoes':
        return pagina('Configurações', [
          bloco(
            tipo == 'Cliente' ? empresa : nome,
            email.isEmpty ? 'Editar perfil' : email,
            () => ir('editar_perfil'),
            icone: Icons.person,
          ),
          bloco(
            'Notificações',
            'Veja suas atualizações',
            () => ir('notificacoes'),
            icone: Icons.notifications_none,
          ),
          bloco(
            'Alterar senha',
            'Altere a senha da conta local',
            () => ir('alterar_senha'),
            icone: Icons.lock_outline,
          ),
          bloco(
            'Privacidade e segurança',
            'Informações sobre o protótipo',
            () => ir('privacidade'),
            icone: Icons.shield_outlined,
          ),
          bloco(
            'Ajuda e suporte',
            'Perguntas frequentes',
            () => ir('ajuda'),
            icone: Icons.help_outline,
          ),
          bloco(
            'Sobre o SkillMatch',
            'Conheça a plataforma',
            () => ir('sobre'),
          ),
          botao('Sair da conta', () async {
            await ContasLocais.sair();
            if (!mounted) return;
            atualizarEstado(() {
              contaAutenticada = false;
              email = '';
              nome = 'Maria da Silva';
              empresa = 'DevCore';
              tipo = 'Freelancer';
              area = 'Desenvolvedora Web';
              descricao = '';
              habilidades = '';
              aba = 0;
              tela = 'boas_vindas';
              historicoTelas.clear();
            });
            emailAcesso.clear();
            senhaAcesso.clear();
          }),
        ]);
      case 'alterar_senha':
        return formulario('Alterar senha', ['Senha atual', 'Nova senha'], (v) async {
          if (!contaAutenticada) { aviso('Entre na sua conta primeiro.'); return; }
          if (v[1].length < 6) { aviso('A nova senha precisa de 6 caracteres.'); return; }
          final erro = await ContasLocais.alterarSenha(email, v[0], v[1]);
          if (!mounted) return;
          if (erro != null) { aviso(erro); return; }
          ir('configuracoes');
          aviso('Senha alterada com sucesso!');
        });
      case 'privacidade':
        return pagina('Privacidade e segurança', [
          const Text(
            'Este é um protótipo acadêmico. As contas e dados são salvos apenas neste navegador. Não utilize senhas pessoais; não existe servidor ou autenticação online.',
          ),
        ]);
      case 'ajuda':
        return pagina('Ajuda e suporte', [
          titulo('Como funciona?'),
          const Text(
            'Freelancers podem procurar oportunidades, enviar propostas, fazer cursos e organizar portfólios. Clientes podem publicar oportunidades e aceitar propostas.',
          ),
        ]);
      case 'sobre':
        return pagina('Sobre o SkillMatch', [
          titulo('SkillMatch'),
          const Text(
            'Plataforma de capacitação e oportunidades para freelancers. Protótipo acadêmico para facilitar a conexão entre talentos e clientes.',
          ),
        ]);
      default:
        return pagina('SkillMatch', [
          botao('Voltar ao início', () => ir('inicio')),
        ]);
    }
  }}
