namespace sony.metro;

using {sony.metro.reuse as reuse} from './myreuse';

using {cuid, managed, temporal} from '@sap/cds/common';
entity student : reuse.address {
    key id     : reuse.Guid;
        name   : String(255);
        age    : Int32;
        gender : String(2);
        rollNo : Integer64;
        //foreign key = name(class)+pk_of_fk(id) = class_id
        class  : Association to one class;
}

entity class {
    key id             : reuse.Guid;
        specialization : String(255);
        semester       : Int32;
        hod            : String(255);
}

entity book {
    key id       : reuse.Guid;
        bookName : localized String(250);
        author   : String(250);
}

entity Subs: cuid, managed, temporal {
    student: Association to one student;
    book: Association to one book;
}