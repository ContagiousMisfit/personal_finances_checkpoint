import 'package:financas_pessoais/models/objetivo.dart';
import 'package:financas_pessoais/models/tipo_objetivo.dart';
import 'package:financas_pessoais/repository/objetivo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';


class ObjetivosCadastroPage extends StatefulWidget {
  const ObjetivosCadastroPage({Key? key}) : super(key: key);

  @override
  State<ObjetivosCadastroPage> createState() => _ObjetivosCadastroPageState();
}

class _ObjetivosCadastroPageState extends State<ObjetivosCadastroPage> {
  final _objetivoRepository = ObjetivoRepository();

  final _nomeController = TextEditingController();
  final _valorNecessarioController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  final _dataLimiteController = TextEditingController();
  final _fraseMotivacaoController = TextEditingController();
  TipoObjetivo? tipoObjetivoSelecionado;


  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traçar novo objetivo'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildNome(),
                const SizedBox(height: 20),
                _buildTipo(),
                const SizedBox(height: 20),
                _buildValor(),
                const SizedBox(height: 20),
                _buildData(),
                const SizedBox(height: 20),
                _buildFraseMotivacao(),
                const SizedBox(height: 20),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Cadastrar'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final nome = _nomeController.text;            
            final data = DateFormat('dd/MM/yyyy').parse(_dataLimiteController.text);
            final valorNecessario= NumberFormat.currency(locale: 'pt_BR')
                .parse(_valorNecessarioController.text.replaceAll('R\$', ''))
                .toDouble();
            var fraseMotivacao = _fraseMotivacaoController.text;
            var tipo = tipoObjetivoSelecionado;


            final objetivo = Objetivo(
              nome: nome,
              valorNecessario: valorNecessario,
              dataLimite: data,
              fraseMotivacao: fraseMotivacao,
              imagem: tipoObjetivoSelecionado!.name,
              tipo: tipoObjetivoSelecionado!,
            );

            await _objetivoRepository.planejarObjetivo(objetivo);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Objetivo traçado com sucesso. Keep it up!')));

            Navigator.of(context).pop(true);
          }
        },
      ),
    );
  }

  TextFormField _buildNome() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        hintText: 'ex.: Uma semana na Nova Zelândia',
        labelText: 'Nome',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.drive_file_rename_outline_sharp),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um nome';
        }
        if (value.length < 5 || value.length > 30) {
          return 'A Descrição deve ter entre 5 e 30 caracteres';
        }
        return null;
      },
    );
  }

    DropdownButtonFormField _buildTipo() {
    return DropdownButtonFormField<TipoObjetivo>(
      value: tipoObjetivoSelecionado,
      items: TipoObjetivo.values.map((tipo) {
        return DropdownMenuItem<TipoObjetivo>(
          value: tipo,
          child: Text(tipo.toString()),
        );
      }).toList(),
      onChanged: (TipoObjetivo? tipoObjetivo) {
        setState(() {
          tipoObjetivoSelecionado = tipoObjetivo;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Selecione o tipo de Objetivo',
        labelText: 'Categoria',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null) {
          return 'Informe um tipo de objetivo';
        }
        return null;
      },
    );
  }

  TextFormField _buildValor() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _valorNecessarioController,
      decoration: const InputDecoration(
        hintText: 'e.x: R\$10.000,00',
        labelText: 'Valor necessário',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_valorNecessarioController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

    TextFormField _buildData() {
    return TextFormField(
      controller: _dataLimiteController,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data Limite',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          _dataLimiteController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
    );
  }

  TextFormField _buildFraseMotivacao() {
    return TextFormField(
      controller: _fraseMotivacaoController,
      decoration: const InputDecoration(
        hintText: '"Todos os nossos sonhos podem-se realizar, se tivermos a coragem de persegui-los. \n(Walt Disney)"',
        labelText: 'Motivação',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
    );
  }

  
}
