import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/models/product.dart';
import 'package:flutter/material.dart';
import 'package:english_order/util/myfilter.dart';
import 'package:english_order/controllers/db_controller.dart';

class UpdateForm extends StatefulWidget {
  final int index;
  final Product person;

  const UpdateForm({
    Key? key,
    required this.index,
    required this.person,
  }) : super(key: key);

  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _personFormKey = GlobalKey<FormState>();

  late final _nameController;
  late final _preisController;
  late final _preisControllerCent;
  late final _kategorieController;
  late final _beschreibungController;
  late String titel;
  final DbController db = DbController();
  String erstesBild = bilder.first;

  _updateInfo() {
    Product product = Product(
      title: _nameController.text,
      image: erstesBild,
      preis: double.parse(_preisController.text) +
          (int.parse(_preisControllerCent.text.substring(0, 2)) * 0.01),
      kategorie: _kategorieController.text,
      beschreibung: _beschreibungController.text,
    );
    db.updateProduct(widget.index, product);
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.title);
    _preisController =
        TextEditingController(text: widget.person.preis.floor().toString());
    _preisControllerCent = TextEditingController(
        text: int.tryParse(
                widget.person.preis.toString().split('.')[1].substring(0, 2))
            .toString());
    _kategorieController = TextEditingController(text: widget.person.kategorie);
    _beschreibungController =
        TextEditingController(text: widget.person.beschreibung);
    erstesBild = (widget.person.image).toString();
    titel = widget.person.title;
  }

  @override
  Widget build(BuildContext context) {
    initImages();
    return SingleChildScrollView(
      child: Form(
        key: _personFormKey,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title',
                  style: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18)),
              TextFormField(
                controller: _nameController,
                validator: _fieldValidator,
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Price',
                            style: TextStyle(
                                color: Color(0XFF8B8B8B), fontSize: 18)),
                        const Text('Dollar',
                            style: TextStyle(
                                color: Color(0XFF8B8B8B),
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        TextFormField(
                          inputFormatters: [MyFilter()],
                          keyboardType: TextInputType.number,
                          controller: _preisController,
                          validator: _fieldValidator,
                        ),
                      ],
                    ),
                  ),
                  const Text(' '),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(' ',
                            style: TextStyle(
                                color: Color(0XFF8B8B8B), fontSize: 18)),
                        const Text('Cent',
                            style: TextStyle(
                                color: Color(0XFF8B8B8B),
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        TextFormField(
                          inputFormatters: [MyFilter()],
                          keyboardType: TextInputType.number,
                          controller: _preisControllerCent,
                          validator: _fieldValidator,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              const Text('Picture',
                  style: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18)),
              DropdownButton<String>(
                value: erstesBild,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      erstesBild = newValue!;
                    },
                  );
                },
                items: bilder.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12.0),
              const Text('Description',
                  style: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18)),
              TextFormField(
                controller: _beschreibungController,
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_personFormKey.currentState!.validate()) {
                      _updateInfo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
