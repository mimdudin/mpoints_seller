import 'package:scoped_model/scoped_model.dart';

import './user_service.dart';
import './customer_service.dart';
import './transaction_service.dart';

class MainModel extends Model with UserService, CustomerService, TransactionService {}
