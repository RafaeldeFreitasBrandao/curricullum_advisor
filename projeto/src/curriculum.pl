
/*Camada Disciplinas*/

/*Disciplinas do 1o Semestre*/
disciplina(fundamentosSistemasCiberfisicos, obrigatoria, 4, 1).
disciplina(resolucaoProblemasLogicaMatematica, obrigatoria, 4, 1).
disciplina(filosofia, obrigatoria, 4, 1).
disciplina(experienciaCriativaNavegandoComputacao, obrigatoria, 6, 1).
disciplina(raciocinioAlgoritimo, obrigatoria, 6, 1).

/*Disciplinas do 2o Semestre*/
disciplina(resolucaoProblemasNaturezaDiscreta, obrigatoria, 4, 2).
disciplina(arquiteturaBancoDados, obrigatoria, 6, 2).
disciplina(programacaoImperativa, obrigatoria, 4, 2).
disciplina(programacaoWeb, obrigatoria, 4, 2).
disciplina(conectividadeSistemasCiberfisicos, obrigatoria, 4, 2).
disciplina(etica, obrigatoria, 2, 2).

/*Disciplinas do 3o Semestre*/

disciplina(modelagemFenomenosFisicos, obrigatoria, 4, 3).
disciplina(experienciaCriativaCriandoSolucoesComputacionais, obrigatoria, 6, 3).
disciplina(programacaoOrientadaObjetos, obrigatoria, 6, 3).
disciplina(segurancaInformacao, obrigatoria, 4, 3).
disciplina(performanceSistemasCiberfisicos, obrigatoria, 4, 3).
disciplina(clinicaTIC, obrigatoria, 2, 3).
/*1a eletiva*/
disciplina(programacaoSegura, eletiva, 2, 3).

/*Disciplinas do 4o Semestre*/

disciplina(teologiaSociedade, obrigatoria, 2, 4).
disciplina(resolucaoProblemasEstruturadosComputacao, obrigatoria, 4, 4).
disciplina(programacaoLogicaFuncional, obrigatoria, 4, 4).
disciplina(bigData, obrigatoria, 4, 4).
disciplina(sistemasOperacionaisCiberfisicos, obrigatoria, 4, 4).
disciplina(redesConvergentes, obrigatoria, 4, 4).
disciplina(modelagemSistemasComputacionais, obrigatoria, 4, 4).

/*Disciplinas do 5o Semestre*/

disciplina(complexidadeAlgoritimos, obrigatoria, 4, 5).
disciplina(metodosQuantitativosComputacao, obrigatoria, 4, 5).
disciplina(resolucaoProblemasGrafos, obrigatoria, 6, 5).
disciplina(metodosPesquisaCientifica, obrigatoria, 4, 5).
disciplina(experienciaCriativaInovandoColaborativamente, obrigatoria, 6, 5).
/*2a eletiva*/
disciplina(geometriaAnaliticaAlgebraLinear, eletiva, 2, 5).

/*Disciplinas do 6o Semestre*/

disciplina(apredizagemMaquina, obrigatoria, 4, 6).
disciplina(inteligenciaArtificial, obrigatoria, 4, 6).
disciplina(programacaoDistribuida, obrigatoria, 4, 6).
disciplina(gestaoProjetosMetodosAgeis, obrigatoria, 6, 6).
disciplina(pesquisaAplicada, obrigatoria, 4, 6).
disciplina(engenhariaSoftware, obrigatoria, 4, 6).
/*3a eletiva*/
disciplina(organizacaoTratamentoInformacao, eletiva, 2, 6).

/*Disciplinas do 7o Semestre*/

disciplina(construcaoInterpretadores, obrigatoria, 4, 7).
disciplina(dataScience, obrigatoria, 6, 7).
disciplina(construcaoSoftwareGrafico3D, obrigatoria, 4, 7).
disciplina(cloudComputing, obrigatoria, 4, 7).
disciplina(arquiteturaSoftware, obrigatoria, 4, 7).
disciplina(experienciaCriativaProjetoTransformadorI, obrigatoria, 4, 7).
/*4a eletiva*/
disciplina(principiosPipelineDadosOrquestracao, eletiva, 2, 7).

/*Disciplinas do 8o Semestre*/

disciplina(processamentoLinguagemNatural, obrigatoria, 4, 8).
disciplina(dEVOPS, obrigatoria, 4, 8).
disciplina(avaliacaoDesempenhoSistemas, obrigatoria, 4, 8).
disciplina(experienciaCriativaProjetoTransformadorII, obrigatoria, 4, 8).
disciplina(mundosVirtuaisRealidadeMisturada, obrigatoria, 4, 8).
disciplina(visaoComputacional, obrigatoria, 4, 8).

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

 /*---CAMADA PRÉ-REQUISITOS--*/

/*1a camada, pré-requisito*/

prerequisito(experienciaCriativaCriandoSolucoesComputacionais, experienciaCriativaNavegandoComputacao).
prerequisito(programacaoImperativa, raciocinioAlgoritimo).

/*2a camada, pré-requisito*/

prerequisito(experienciaCriativaInovandoColaborativamente, experienciaCriativaCriandoSolucoesComputacionais).
prerequisito(programacaoOrientadaObjetos, programacaoImperativa).

/*3a camada, pré-requisito*/

prerequisito(experienciaCriativaProjetoTransformadorI, experienciaCriativaInovandoColaborativamente).
prerequisito(programacaoLogicaFuncional, programacaoOrientadaObjetos).

/*4a camada, pré-requisito*/
prerequisito(experienciaCriativaProjetoTransformadorII, experienciaCriativaProjetoTransformadorI).
prerequisito(programacaoDistribuida, programacaoLogicaFuncional).

/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

/*---CAMADA ALUNOS---*/

/*Alunos cadastrados*/

aluno(jubileu).
aluno(noslen).
aluno(tremilik).

/*Contexto: Jubileu, Noslen e Tremilik entraram na faculdade em 2025/2, e estão no 3o período*/

/*Aluno: Jubileu -----> Adiantado*/

cursou(jubileu,fundamentosSistemasCiberfisicos).
cursou(jubileu,resolucaoProblemasLogicaMatematica).
cursou(jubileu,filosofia).
cursou(jubileu,experienciaCriativaNavegandoComputacao).
cursou(jubileu,raciocinioAlgoritimo).
cursou(jubileu,resolucaoProblemasNaturezaDiscreta).
cursou(jubileu,arquiteturaBancoDados).
cursou(jubileu,programacaoImperativa).
cursou(jubileu,programacaoWeb).
cursou(jubileu,conectividadeSistemasCiberfisicos).
cursou(jubileu,modelagemFenomenosFisicos).
cursou(jubileu,experienciaCriativaCriandoSolucoesComputacionais).
cursou(jubileu,programacaoOrientadaObjetos).
cursou(jubileu,segurancaInformacao).
cursou(jubileu,performanceSistemasCiberfisicos).
cursou(jubileu,clinicaTIC).
cursou(jubileu,programacaoSegura).


/*matérias adiantadas do 3o período*/
cursou(jubileu,teologiaSociedade).
cursou(jubileu,bigData).
cursou(jubileu,geometriaAnaliticaAlgebraLinear).


/*Aluno: Noslen -----> Padrão*/

cursou(noslen,fundamentosSistemasCiberfisicos).
cursou(noslen,resolucaoProblemasLogicaMatematica).
cursou(noslen,filosofia).
cursou(noslen,experienciaCriativaNavegandoComputacao).
cursou(noslen,raciocinioAlgoritimo).
cursou(noslen,resolucaoProblemasNaturezaDiscreta).
cursou(noslen,arquiteturaBancoDados).
cursou(noslen,programacaoImperativa).
cursou(noslen,programacaoWeb).
cursou(noslen,conectividadeSistemasCiberfisicos).
cursou(noslen,etica).
cursou(noslen,modelagemFenomenosFisicos).
cursou(noslen,experienciaCriativaCriandoSolucoesComputacionais).
cursou(noslen,programacaoOrientadaObjetos).
cursou(noslen,segurancaInformacao).
cursou(noslen,performanceSistemasCiberfisicos).
cursou(noslen,clinicaTIC).
cursou(noslen,programacaoSegura).


/*Aluno: Tremilik -----> Atrasado*/

cursou(tremilik,fundamentosSistemasCiberfisicos).
cursou(tremilik,resolucaoProblemasLogicaMatematica).
cursou(tremilik,experienciaCriativaNavegandoComputacao).
cursou(tremilik,raciocinioAlgoritimo).
cursou(tremilik,programacaoImperativa).
cursou(tremilik,arquiteturaBancoDados).
cursou(tremilik,conectividadeSistemasCiberfisicos).
cursou(tremilik,etica).






