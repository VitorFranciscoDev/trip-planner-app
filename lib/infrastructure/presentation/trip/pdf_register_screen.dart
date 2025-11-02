import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:trip_planner/entities/trip.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

class PDFRegisterScreen extends StatefulWidget {
  const PDFRegisterScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<PDFRegisterScreen> createState() => _PDFRegisterScreenState();
}

class _PDFRegisterScreenState extends State<PDFRegisterScreen> {
  final ImagePicker _picker = ImagePicker();
  
  // Fotos das pessoas do grupo
  Map<int, File?> personPhotos = {};
  
  // Fotos e descrições das paradas
  Map<int, List<File>> stopPhotos = {};
  Map<int, TextEditingController> stopDescriptions = {};

  @override
  void initState() {
    super.initState();
    // Inicializa controllers para cada parada
    for (int i = 0; i < widget.trip.stops!.length; i++) {
      stopPhotos[i] = [];
      stopDescriptions[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    stopDescriptions.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _pickPersonPhoto(int index) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    
    if (image != null) {
      setState(() {
        personPhotos[index] = File(image.path);
      });
    }
  }

  Future<void> _pickStopPhoto(int stopIndex) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1500,
      maxHeight: 1500,
    );
    
    if (image != null) {
      setState(() {
        stopPhotos[stopIndex]?.add(File(image.path));
      });
    }
  }

  void _removeStopPhoto(int stopIndex, int photoIndex) {
    setState(() {
      stopPhotos[stopIndex]?.removeAt(photoIndex);
    });
  }

  Future<void> _generatePDF() async {
    // Validação
    bool hasAllPersonPhotos = widget.trip.group!.length == personPhotos.length;
    bool hasAllStopData = widget.trip.stops!.every((stop) {
      int index = widget.trip.stops!.indexOf(stop);
      return stopPhotos[index]!.isNotEmpty && 
             stopDescriptions[index]!.text.isNotEmpty;
    });

    if (!hasAllPersonPhotos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Please add photos for all group members"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (!hasAllStopData) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text("Please add photos and descriptions for all stops")),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Mostra loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Generating PDF...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final pdf = pw.Document();

      // Página de Capa
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                gradient: pw.LinearGradient(
                  colors: [
                    PdfColor.fromHex('#1E88E5'),
                    PdfColor.fromHex('#1565C0'),
                  ],
                  begin: pw.Alignment.topLeft,
                  end: pw.Alignment.bottomRight,
                ),
              ),
              child: pw.Center(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Icon(
                      pw.IconData(0xe539), // flight_takeoff icon
                      size: 100,
                      color: PdfColors.white,
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      widget.trip.title,
                      style: pw.TextStyle(
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 15),
                    pw.Text(
                      "${widget.trip.start_date} - ${widget.trip.end_date}",
                      style: pw.TextStyle(
                        fontSize: 20,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 50),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(30),
                      ),
                      child: pw.Text(
                        "Travel Memories",
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#1E88E5'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      // Página do Grupo
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Travel Group",
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#1E88E5'),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(widget.trip.group!.length, (index) {
                    final person = widget.trip.group![index];
                    final photo = personPhotos[index];
                    
                    return pw.Container(
                      width: 150,
                      child: pw.Column(
                        children: [
                          pw.Container(
                            width: 120,
                            height: 120,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(15),
                              border: pw.Border.all(
                                color: PdfColor.fromHex('#1E88E5'),
                                width: 3,
                              ),
                            ),
                            child: photo != null
                                ? pw.ClipRRect(
                                    horizontalRadius: 12,
                                    verticalRadius: 12,
                                    child: pw.Image(
                                      pw.MemoryImage(photo.readAsBytesSync()),
                                      fit: pw.BoxFit.cover,
                                    ),
                                  )
                                : pw.Center(
                                    child: pw.Icon(
                                      pw.IconData(0xe7fd), // person icon
                                      size: 50,
                                      color: PdfColor.fromHex('#1E88E5'),
                                    ),
                                  ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            person.name,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            "${person.age} years old",
                            style: pw.TextStyle(
                              fontSize: 11,
                              color: PdfColors.grey700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      );

      // Páginas das Paradas
      for (int i = 0; i < widget.trip.stops!.length; i++) {
        final stop = widget.trip.stops![i];
        final photos = stopPhotos[i]!;
        final description = stopDescriptions[i]!.text;

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return [
                // Header da Parada
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#1E88E5'),
                    borderRadius: pw.BorderRadius.circular(15),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 40,
                        height: 40,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          shape: pw.BoxShape.circle,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            "${i + 1}",
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex('#1E88E5'),
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              stop.location,
                              style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "${stop.start_date} - ${stop.end_date}",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Experiências
                if (stop.stopExperiences != null && stop.stopExperiences!.isNotEmpty)
                  pw.Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: stop.stopExperiences!.map((exp) {
                      return pw.Container(
                        padding: pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#E3F2FD'),
                          borderRadius: pw.BorderRadius.circular(15),
                          border: pw.Border.all(
                            color: PdfColor.fromHex('#1E88E5'),
                            width: 1,
                          ),
                        ),
                        child: pw.Text(
                          exp.experience,
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#1E88E5'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                
                if (stop.stopExperiences != null && stop.stopExperiences!.isNotEmpty)
                  pw.SizedBox(height: 20),

                // Descrição
                pw.Text(
                  "Our Experience",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#1E88E5'),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Text(
                    description,
                    style: pw.TextStyle(
                      fontSize: 12,
                      lineSpacing: 1.5,
                    ),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),
                pw.SizedBox(height: 20),

                // Fotos
                pw.Text(
                  "Photo Gallery",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#1E88E5'),
                  ),
                ),
                pw.SizedBox(height: 15),
                
                // Grid de fotos
                pw.Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: photos.map((photo) {
                    return pw.Container(
                      width: 170,
                      height: 170,
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(12),
                        border: pw.Border.all(
                          color: PdfColor.fromHex('#1E88E5'),
                          width: 2,
                        ),
                      ),
                      child: pw.ClipRRect(
                        horizontalRadius: 10,
                        verticalRadius: 10,
                        child: pw.Image(
                          pw.MemoryImage(photo.readAsBytesSync()),
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ];
            },
          ),
        );
      }

      // Fecha o loading
      Navigator.of(context).pop();

      // Abre preview do PDF
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("PDF generated successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      // Fecha o loading se estiver aberto
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text("Error generating PDF: ${e.toString()}")),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(
          "Create Trip Booklet",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book, color: theme.colorScheme.primary, size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.trip.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                              fontFamily: "Times New Roman",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${widget.trip.start_date} - ${widget.trip.end_date}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Group Photos Section
              Row(
                children: [
                  Icon(Icons.group, color: theme.colorScheme.primary, size: 22),
                  SizedBox(width: 8),
                  Text(
                    "Group Members Photos",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(widget.trip.group!.length, (index) {
                    final person = widget.trip.group![index];
                    final hasPhoto = personPhotos[index] != null;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: index < widget.trip.group!.length - 1 ? 15 : 0),
                      child: Row(
                        children: [
                          // Photo
                          GestureDetector(
                            onTap: () => _pickPersonPhoto(index),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: hasPhoto ? null : theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                                image: hasPhoto ? DecorationImage(
                                  image: FileImage(personPhotos[index]!),
                                  fit: BoxFit.cover,
                                ) : null,
                              ),
                              child: hasPhoto ? null : Icon(
                                Icons.add_a_photo,
                                color: theme.colorScheme.primary,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${person.age} years old",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Status
                          Icon(
                            hasPhoto ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: hasPhoto ? Colors.green : Colors.grey[400],
                            size: 24,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 30),

              // Stops Section
              Row(
                children: [
                  Icon(Icons.location_on, color: theme.colorScheme.primary, size: 22),
                  SizedBox(width: 8),
                  Text(
                    "Trip Stops",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              ...List.generate(widget.trip.stops!.length, (index) {
                final stop = widget.trip.stops![index];
                final photos = stopPhotos[index]!;
                final controller = stopDescriptions[index]!;
                
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stop Header
                        Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stop.location,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Text(
                                    "${stop.start_date} - ${stop.end_date}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        
                        // Photos
                        Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...photos.map((photo) {
                              final photoIndex = photos.indexOf(photo);
                              return Stack(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: FileImage(photo),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: IconButton(
                                      icon: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.close, color: Colors.white, size: 16),
                                      ),
                                      onPressed: () => _removeStopPhoto(index, photoIndex),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            
                            // Add Photo Button
                            GestureDetector(
                              onTap: () => _pickStopPhoto(index),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  color: theme.colorScheme.primary,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        
                        // Description
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        
                        TextField(
                          controller: controller,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Write about your experience at ${stop.location}...",
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              SizedBox(height: 20),

              // Generate PDF Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generatePDF,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf, size: 24),
                      SizedBox(width: 10),
                      Text(
                        "Generate PDF Booklet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}