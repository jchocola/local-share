import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/utils/show_toastification.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:lottie/lottie.dart';
import 'package:bonsoir/bonsoir.dart';

class SearchingAnimationWithFoundedDevices extends StatefulWidget {
  const SearchingAnimationWithFoundedDevices({super.key});

  @override
  State<SearchingAnimationWithFoundedDevices> createState() =>
      _SearchingAnimationWithFoundedDevicesState();
}

class _SearchingAnimationWithFoundedDevicesState
    extends State<SearchingAnimationWithFoundedDevices> {
  final List<BonsoirService> discoveredServices = [];
  final Random _random = Random();
  final List<Offset> _avatarPositions = [];
  int? _selectedAvatarIndex;
  Offset? _dragStartOffset;

  @override
  void initState() {
    super.initState();
    // Initialize empty positions array
    _avatarPositions.clear();
  }

  void _updateAvatarPositions() {
    setState(() {
      _avatarPositions.clear();
      for (int i = 0; i < discoveredServices.length; i++) {
        _avatarPositions.add(
          Offset(_random.nextDouble() * 200, _random.nextDouble() * 200),
        );
      }
    });
  }

  void _onPanStart(int index, DragStartDetails details) {
    setState(() {
      _selectedAvatarIndex = index;
      _dragStartOffset = details.localPosition;
    });
  }

  void _onPanUpdate(int index, DragUpdateDetails details) {
    if (_selectedAvatarIndex == index) {
      setState(() {
        _avatarPositions[index] = Offset(
          _avatarPositions[index].dx + details.delta.dx,
          _avatarPositions[index].dy + details.delta.dy,
        );
      });
    }
  }

  void _onPanEnd(int index, DragEndDetails details) {
    setState(() {
      _selectedAvatarIndex = null;
      _dragStartOffset = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SendPageBloc, SendPageBlocState>(
      listener: (context, state) {
        if (state is SendPageBlocState_BonsoirDiscoveryStartedEvent) {
          showSuccessToatification(context, title: 'Bonsoir Discovery Started');
        }

        if (state is SendPageBlocState_BonsoirDiscoveryServiceFoundEvent) {
          // Add the discovered service to our list
          if (!discoveredServices.contains(state.bonsoirService)) {
            setState(() {
              discoveredServices.add(state.bonsoirService);
              _updateAvatarPositions();
            });
          }
          showSuccessToatification(context, title: 'Device Found: ${state.bonsoirService.name}');
        }
        
        if (state is SendPageBlocState_connected) {
          showSuccessToatification(context, title: 'Connected to ${state.service.name}');
          // Navigate to file selection/transfer screen
          context.push('/send_page/confirm_transfer');
        }
        
        if (state is SendPageBlocState_error) {
          showErrorToatification(context, title: state.message);
        }
      },
      builder: (context, state) {
        if (state is SendPageBlocState_discovering || 
            state is SendPageBlocState_BonsoirDiscoveryStartedEvent ||
            state is SendPageBlocState_BonsoirDiscoveryServiceFoundEvent) {
          return Stack(
            children: [
              /// searching animation
              Lottie.asset(
                'assets/Searching_Animation.json',
                width: size.width * 0.7,
                height: size.width * 0.7,
              ),

              // Display discovered devices
              for (int i = 0; i < discoveredServices.length && i < _avatarPositions.length; i++)
                Positioned(
                  left: _avatarPositions[i].dx,
                  top: _avatarPositions[i].dy,
                  child: DraggableAvatar(
                    name: discoveredServices[i].name ?? 'Unknown Device',
                    index: i,
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    onTap: () {
                      // Connect to the selected device
                      context.read<SendPageBloc>().add(
                        SendPageBlocEvent_connectToDevice(service: discoveredServices[i])
                      );
                    },
                    isDragging: _selectedAvatarIndex == i,
                  ),
                ),
            ],
          );
        } else if (state is SendPageBlocState_connecting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Connecting to ${state.service.name}...'),
              ],
            ),
          );
        } else if (state is SendPageBlocState_connected) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 20),
                Text('Connected to ${state.service.name}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.push('/send_page/confirm_transfer');
                  },
                  child: Text('Select Files to Send'),
                ),
              ],
            ),
          );
        } else if (state is SendPageBlocState_error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 60),
                SizedBox(height: 20),
                Text('Error: ${state.message}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<SendPageBloc>().add(SendPageBlocEvent_startBonsoirDiscover());
                  },
                  child: Text('Retry Discovery'),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class DraggableAvatar extends StatelessWidget {
  final String name;
  final int index;
  final Function(int, DragStartDetails) onPanStart;
  final Function(int, DragUpdateDetails) onPanUpdate;
  final Function(int, DragEndDetails) onPanEnd;
  final VoidCallback onTap;
  final bool isDragging;

  const DraggableAvatar({
    super.key,
    required this.name,
    required this.index,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => onPanStart(index, details),
      onPanUpdate: (details) => onPanUpdate(index, details),
      onPanEnd: (details) => onPanEnd(index, details),
      onTap: onTap,
      child: Transform.scale(
        scale: isDragging ? 1.1 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: isDragging
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ]
                : [],
          ),
          child: CustomAvatar(name: name),
        ),
      ),
    );
  }
}